require File.join(File.dirname(__FILE__), 'log_parser_notifier', 'version')
require File.join(File.dirname(__FILE__), 'log_parser_notifier', '/log_reader')
require File.join(File.dirname(__FILE__), 'log_parser_notifier', '/rails_request_notifier')

require 'logger'
require 'request_log_analyzer'


module LogParserNotifier
  def self.logger
    @logger ||= Logger.new(STDOUT)

    if defined? LogParserNotifier::LogLevel
      @logger.level = LogParserNotifier::LogLevel
    else
      @logger.level = Logger::WARN
    end

    @logger
  end
end
