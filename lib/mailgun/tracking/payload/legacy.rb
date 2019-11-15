# frozen_string_literal: true

module Mailgun
  module Tracking
    class Payload
      # Legacy payload object.
      class Legacy
        def initialize(options = {})
          @options = options
          warn(<<~DEPRECATION)
            [Mailgun::Tracking] The Legacy class refers to a previous version of the API
            which is deprecated and it will be removed in the next major version.
          DEPRECATION
        end

        def body
          @options
        end

        def event
          @event ||= @options.fetch('event')
        end

        def token
          @token ||= @options.fetch('token')
        end

        def timestamp
          @timestamp ||= @options.fetch('timestamp')
        end

        def signature
          @signature ||= @options.fetch('signature')
        end
      end
    end
  end
end
