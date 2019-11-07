# frozen_string_literal: true

module Mailgun
  module Tracking
    class Payload
      def initialize(options = {})
        @options = options
      end

      def body
        @options
      end

      def event
        @event ||= __event_data.fetch('event')
      end

      def token
        @token ||= __signature.fetch('token')
      end

      def timestamp
        @timestamp ||= __signature.fetch('timestamp')
      end

      def signature
        @signature ||= __signature.fetch('signature')
      end

      private

      def __signature
        @__signature ||= @options.fetch('signature')
      end

      def __event_data
        @__event_data ||= @options.fetch('event-data')
      end
    end
  end
end
