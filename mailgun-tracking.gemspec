lib = File.expand_path('lib', __dir__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'mailgun/tracking/version'

Gem::Specification.new do |spec|
  spec.name          = 'mailgun-tracking'
  spec.version       = Mailgun::Tracking::Version
  spec.authors       = ['Artem Chubchenko']
  spec.email         = ['artem.chubchenko@gmail.com']

  spec.summary       = 'Integration with Mailgun Webhooks'
  spec.description   = spec.summary
  spec.homepage      = 'https://github.com/chubchenko/mailgun-tracking'
  spec.license       = 'MIT'

  spec.files         = Dir['{lib}/**/*']
  spec.test_files    = Dir['{spec}/**/*']
  spec.require_paths = ['lib']

  spec.required_ruby_version = '>= 2.2.0'

  spec.add_development_dependency 'appraisal', '~> 2.2'
  spec.add_development_dependency 'rack-test'

  spec.add_development_dependency 'fasterer'
  spec.add_development_dependency 'overcommit'
  spec.add_development_dependency 'rake'
  spec.add_development_dependency 'rubocop'
  spec.add_development_dependency 'rubocop-rspec'

  spec.add_development_dependency 'codeclimate-test-reporter'
  spec.add_development_dependency 'rack'
  spec.add_development_dependency 'rspec'
  spec.add_development_dependency 'simplecov'
end
