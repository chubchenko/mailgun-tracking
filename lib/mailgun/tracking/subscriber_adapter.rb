module Mailgun
  module Tracking
    class SubscriberAdapter
      def self.call(callable)
        new(callable)
      end

      def initialize(callable)
        @callable = callable
      end

      def call(payload)
        @callable.call(payload)
      end
    end
  end
end
