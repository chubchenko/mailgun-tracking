ENV['RAILS_ENV'] = 'test'

require 'rails'
require 'mailgun/tracking/railtie'

module Dummy
  class Application < Rails::Application
    config.secret_token = '6e394142b6fb6349707ea48841f9cb5898c182c855c002689866aac50d6d4bda'
    config.secret_key_base = '08e540044922f3ecef8e4e1e672d0f7d1cfa56a80d20e5ee68d8006aab5afb83'

    log_path = File.join(File.dirname(__FILE__), 'logs', 'test.log')
    config.logger = Logger.new(log_path)
    Rails.logger = config.logger

    config.eager_load = false
  end
end

Dummy::Application.initialize!
