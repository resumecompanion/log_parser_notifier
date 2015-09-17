# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'log_parser_notifier/version'

Gem::Specification.new do |spec|
  spec.name          = 'log_parser_notifier'
  spec.version       = LogParserNotifier::VERSION
  spec.authors       = ['Josh Moore']
  spec.email         = ['joshsmoore@gmail.com']
  spec.summary       = 'A small gem untilizing request-log-analyxer to send'\
                       ' request events to logging solutions'
  spec.description   = 'Write a longer description. Optional.'
  spec.homepage      = ''
  spec.license       = 'MIT'

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ['lib']

  spec.add_dependency 'request-log-analyzer', '~> 1.13.4'
  spec.add_dependency 'slop', '~> 4.2.0'
  spec.add_dependency 'dogstatsd-ruby', '~> 1.5.0'

  spec.add_development_dependency 'bundler', '~> 1.7'
  spec.add_development_dependency 'rake', '~> 10.0'
  spec.add_development_dependency 'rspec', '~> 3.3.0'
end
