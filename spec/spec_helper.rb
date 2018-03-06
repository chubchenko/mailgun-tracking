require 'rack'
require 'rack/test'
require 'simplecov'
require 'bundler/setup'
require 'mailgun/tracking'

require_relative 'support/fixture'
require_relative 'support/rack_helpers'
require_relative 'support/shared_examples/subscriber'

SimpleCov.start

RSpec.configure do |config|
  config.include(RackHelpers)
  config.include(Rack::Test::Methods)

  config.before do
    Mailgun::Tracking.configure do |c|
      c.api_key = 'key-qblubkqnkdn4lfes5oscf57ryllaia42'
      c.endpoint = '/mailgun'
    end
  end

  config.expect_with :rspec do |c|
    c.syntax = :expect
  end

  config.order = :random
end
