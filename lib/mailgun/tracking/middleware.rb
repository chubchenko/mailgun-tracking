# frozen_string_literal: true

module Mailgun
  module Tracking
    # Rack-based middleware to handle event notifications.
    class Middleware
      # Initializes a new Middleware object.
      #
      # @param app the next Rack middleware in the stack.
      def initialize(app)
        @app = app
      end

      # Thread-safe {call!}.
      #
      # @param env [Hash] Environment hash.
      #
      # @return [Array(Numeric,Hash,Array)] The Rack-style response.
      def call(env)
        dup.call!(env)
      end

      # Responds to Rack requests.
      #
      # @param env [Hash] Environment hash.
      #
      # @return [Array(Numeric,Hash,Array)] The Rack-style response.
      def call!(env)
        @request = Request.new(env)
        return @app.call(env) unless @request.mailgun_tracking?

        handle_event
      end

      private

      # @return [Array(Numeric,Hash,Array)] The Rack-style response.
      def null_response
        [200, {}, []]
      end

      # @return [Array(Numeric,Hash,Array)] The Rack-style response.
      def bad_request
        [400, {}, []]
      end

      def handle_event
        Mailgun::Tracking.notifier.broadcast(@request.params.fetch('event'), @request.payload)
        null_response
      rescue InvalidSignature
        bad_request
      end
    end
  end
end
