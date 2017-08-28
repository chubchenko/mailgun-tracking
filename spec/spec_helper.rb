require 'rack'
require 'simplecov'
require 'bundler/setup'
require 'mailgun/tracking'

require_relative 'support/fixture'
require_relative 'support/rack_helpers'
require_relative 'support/shared_examples/subscriber'

SimpleCov.start

RSpec.configure do |config|
  config.include(RackHelpers)

  config.before(:each) do
    Mailgun::Tracking.configure(api_key: 'key-qblubkqnkdn4lfes5oscf57ryllaia42', endpoint: '/mailgun')
  end

  config.expect_with :rspec do |c|
    c.syntax = :expect
  end

  config.order = :random
end
