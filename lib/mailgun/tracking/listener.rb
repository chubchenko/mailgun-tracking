module Mailgun
  module Tracking
    class Listener
      attr_reader :subscribers

      def initialize
        @subscribers = Hash.new { |h, k| h[k] = [] }
      end

      def add_subscriber(name, subscriber)
        @subscribers[name.to_sym] << subscriber
      end

      def broadcast(name, payload)
        @subscribers[name.to_sym].each { |subscriber| subscriber.call(payload) }
      end
    end
  end
end
