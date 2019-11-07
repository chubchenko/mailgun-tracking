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

        # TODO: will be uncommented after drop support
        # return @app.call(env) unless ['application/json'].include?(request.media_type)
        if ['application/json'].include?(@request.media_type)
          body = env['rack.input'].read

          env['rack.input'].rewind

          env.update('rack.request.form_hash' => JSON.parse(body), 'rack.request.form_input' => env['rack.input'])
        end

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
        payload = payload_for(@request.params)
        Mailgun::Tracking.notifier.broadcast(payload.event, payload)
        null_response
      rescue InvalidSignature
        bad_request
      end

      def payload_for(params)
        return Payload::Legacy.new(params) if params.key?('timestamp')

        Payload.new(params)
      end
    end
  end
end
