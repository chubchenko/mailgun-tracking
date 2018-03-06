ENV['RAILS_ENV'] = 'test'

require 'rails'

class Dummy < Rails::Application
  config.secret_token = '1'

  config.secret_key_base = '2'

  log_path = File.join(File.dirname(__FILE__), 'logs', 'test.log')
  config.logger = Logger.new(log_path)
  Rails.logger = config.logger

  config.middleware.use(Mailgun::Tracking::Middleware)

  config.eager_load = false
end

class Delivered
  def call(payload); end
end

Dummy.initialize!
