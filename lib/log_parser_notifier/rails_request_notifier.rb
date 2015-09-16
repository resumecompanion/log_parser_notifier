require 'statsd'

module LogParserNotifier
  class RailsRequestNotifier
    def initialize(log_file)
      @log_reader = LogReader.new log_file
    end

    def parser
      @parser ||= parser = RequestLogAnalyzer::Source::LogParser.new(RequestLogAnalyzer::FileFormat::Rails3.create)
    end

    def statsd
      @statsd ||= Statsd.new('localhost', 8125)
    end

    def parse_and_trigger_notifications
      parser.parse_stream @log_reader.log_io do |request|
        tags = %W(controller:#{request[:controller]} action:#{request[:action]} con_act:#{request[:controller]}##{request[:action]})
        
        statsd.increment 'rails.requests', tags: tags
        statsd.timing 'rails.load_time', request[:duration] * 1000, tags: tags
      end
    end
  end
end
