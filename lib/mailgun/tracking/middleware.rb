module Mailgun
  module Tracking
    # Rack-based middleware to handle event notifications.
    class Middleware
      BAD_REQUEST = [400, {}, ['Bad request']].freeze

      # Initializes a new Middleware object.
      #
      # @param app the next Rack middleware in the stack.
      def initialize(app)
        @app = app
      end

      # Responds to Rack requests.
      #
      # @param env [Hash] Environment hash.
      #
      # @return [Array(Numeric,Hash,Array)] The Rack-style response.
      def call(env)
        @env = env

        if mailgun_tracking_request?
          begin
            Mailgun::Tracking.notifier.broadcast(request.params.fetch('event'), request.params)
            null_response
          rescue InvalidSignature
            BAD_REQUEST
          end
        else
          @app.call(env)
        end
      end

      private

      # Interface to a Rack environment.
      #
      # @return [Rack::Request]
      def request
        ::Rack::Request.new(@env)
      end

      # Checks if the path of the request is equal to the endpoint.
      #
      # @return [Boolean]
      def mailgun_tracking_request?
        return false unless request.post?
        return false unless request.path == Configuration.instance.endpoint
        true
      end

      # @return [Array(Numeric,Hash,Array)] The Rack-style response.
      def null_response
        [200, {}, []]
      end
    end
  end
end
