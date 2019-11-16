# frozen_string_literal: true

require 'rack/request'

module Mailgun
  module Tracking
    # Provides a convenient interface to a Rack environment.
    class Request < ::Rack::Request
      # Checks if the request is respond to the specified URL.
      #
      # @return [Boolean]
      def mailgun_tracking?
        return false unless post?
        return false unless media_type == APPLICATION_JSON

        path == Configuration.instance.endpoint
      end

      # @return [Mailgun::Tracking::Payload]
      def payload
        @payload ||= Payload.new(params)
      end

      # A Mailgun::Tracking::Request::JSON is used to parsing JSON requests.
      module JSON
        APPLICATION_JSON = 'application/json'
        FORM_HASH = 'rack.request.form_hash'
        FORM_INPUT = 'rack.request.form_input'

        # Returns the data received in the request body.
        #
        # @return [Hash]
        def POST
          return super unless media_type == APPLICATION_JSON

          body = self.body.read
          self.body.rewind
          env.update(FORM_HASH => ::JSON.parse(body), FORM_INPUT => body)

          get_header(FORM_HASH)
        end
      end

      include JSON
    end
  end
end
