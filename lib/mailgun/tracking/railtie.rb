module Mailgun
  module Tracking
    class Railtie < Rails::Railtie
      initializer 'mailgun-tracking.insert_middleware' do |app|
        # TODO: Rack -> Middleware?
        app.config.middleware.use 'Mailgun::Tracking::Rack'
      end
    end
  end
end
