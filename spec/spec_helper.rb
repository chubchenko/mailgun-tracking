require 'rack'
require 'bundler/setup'
require 'mailgun/tracking'

require_relative 'support/fixture'
require_relative 'support/rack_helpers'

Mailgun::Tracking.configure do |config|
  config.api_key = 'key-qblubkqnkdn4lfes5oscf57ryllaia42'
end

RSpec.configure do |config|
  config.include(RackHelpers)

  config.expect_with :rspec do |c|
    c.syntax = :expect
  end

  config.order = :random
end
