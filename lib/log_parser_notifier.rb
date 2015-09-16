require 'log_parser_notifier/version'
require 'log_parser_notifier/log_reader'
require 'logger'



# logger.debug("Created logger")
# logger.info("Program started")
# logger.warn("Nothing to do!")


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
  # Your code goes here...
end
