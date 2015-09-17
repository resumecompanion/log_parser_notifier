require 'bundler/setup'
require 'logger'
require 'pry'

Bundler.setup

module LogParserNotifier
  LogLevel = Logger::DEBUG
end

require 'log_parser_notifier' # and any other gems you need

RSpec.configure do |config|
  config.expect_with :rspec do |expectations|
    expectations.include_chain_clauses_in_custom_matcher_descriptions = true
  end

  config.mock_with :rspec do |mocks|
    mocks.verify_partial_doubles = true
  end
end
