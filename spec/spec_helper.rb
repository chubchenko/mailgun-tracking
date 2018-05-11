require 'rack/test'
require 'bundler/setup'
require 'mailgun/tracking'

Dir.glob(File.expand_path('support/**/*.rb', __dir__), &method(:require))

RSpec.configure do |config|
  config.include(RackHelpers)
  config.include(Rack::Test::Methods, type: :integration)

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
