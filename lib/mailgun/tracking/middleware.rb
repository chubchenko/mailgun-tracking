module Mailgun
  module Tracking
    class Middleware
      def initialize(app)
        @app = app
      end

      def call(env)
        @env = env

        if mailgun_tracking_request?
          Mailgun::Tracking.notifier.broadcast(request.params.fetch('event'), request.params)
          [200, {}, []]
        else
          @app.call(env)
        end
      end

      private

      def request
        ::Rack::Request.new(@env)
      end

      def mailgun_tracking_request?
        return false unless request.post?
        return false unless request.path == Mailgun::Tracking.endpoint
        true
      end
    end
  end
end
