require 'log_parser_notifier/version'
require 'log_parser_notifier/log_reader'
require 'logger'

logger = Logger.new(STDOUT)
logger.level = Logger::WARN

logger.debug("Created logger")
logger.info("Program started")
logger.warn("Nothing to do!")


module LogParserNotifier
  # Your code goes here...
end
