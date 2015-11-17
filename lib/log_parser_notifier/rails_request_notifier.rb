require 'statsd'
require 'time'

module LogParserNotifier
  class RailsRequestNotifier
    def initialize(log_file, slow_request_threshold = 500)
      @log_reader = LogReader.new log_file
      @slow_request_threshold = slow_request_threshold
      puts @slow_request_threshold
    end

    def parser
      @parser ||= RequestLogAnalyzer::Source::LogParser.new(RequestLogAnalyzer::FileFormat::Rails3.create)
    end

    def statsd
      @statsd ||= Statsd.new('localhost', 8125)
    end

    def parse_and_trigger_notifications
      parser.parse_stream @log_reader.log_io do |request|
        tags = %W(controller:#{request[:controller]} action:#{request[:action]} con_act:#{request[:controller]}##{request[:action]})

        LogParserNotifier.logger.debug("processing request for #{request[:controller]}##{request[:action]} with status: #{request[:status]} it is complete: #{request.completed?}")
        if request.completed? && request[:status] >= 200 && request[:status] < 400
          statsd.increment 'rails.requests', tags: tags
          statsd.timing 'rails.load_time', request[:duration] * 1000, tags: tags

          if request[:duration] * 1000 >= @slow_request_threshold
            log = request.lines.collect { |line_hash| RailsRequestNotifier.render_line(line_hash) }.join("\n")
            statsd.event(
              "#{request[:controller]}##{request[:action]} #{request[:method]} slow request #{request[:duration]} sec",
              log,
              {
                date_happened: Time.parse(request[:timestamp].to_s).to_i.to_s,
                aggregation_key: 'slow_request_rails',
                source_type_name: 'rails_log',
                alert_type: 'warning',
                tags: tags
              }
            )
          end
        else
          statsd.increment 'rails.failed_requests', tags: tags
        end
      end
    end

    def self.render_line(line_hash)
      case line_hash[:line_type]
      when :started
        %Q(Started #{line_hash[:method]} "#{line_hash[:path]}" for #{line_hash[:ip]} at #{Time.parse(line_hash[:timestamp].to_s)})
      when :processing
        %Q(Processing by #{line_hash[:controller]}##{line_hash[:action]} as #{line_hash[:format]})
      when :parameters
        %Q(Parameters: #{line_hash[:params].inspect})
      when :rendered
        "  Rendered #{line_hash[:rendered_file]} (#{line_hash[:partial_duration]}ms)"
      when :completed
        "Completed #{line_hash[:status]} OK in #{(line_hash[:duration] * 1000).to_i}ms (Views: #{(line_hash[:view] || 0) * 1000}ms | ActiveRecord: #{(line_hash[:db] || 0) * 1000}ms)"
      else
        line_hash.inspect
      end
    end
  end
end
