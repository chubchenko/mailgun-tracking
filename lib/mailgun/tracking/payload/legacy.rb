module Mailgun
  module Tracking
    class Payload
      class Legacy
        def initialize(options = {})
          @options = options
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
