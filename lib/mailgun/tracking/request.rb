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

        path == Configuration.instance.endpoint
      end

      # @return [Mailgun::Tracking::Payload, Mailgun::Tracking::Payload::Legacy]
      def payload
        @payload ||= begin
          if params.key?('timestamp')
            ::Mailgun::Tracking::Payload::Legacy.new(params)
          else
            ::Mailgun::Tracking::Payload.new(params)
          end
        end
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
