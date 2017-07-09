module Mailgun
  module Tracking
    class Listener
      attr_reader :subscribers

      def initialize
        @subscribers = Hash.new { |h, k| h[k] = [] }
      end

      def add_subscriber(event, &block)
        @subscribers[event.to_sym] << block
      end

      def broadcast(event, payload)
        @subscribers[event.to_sym].each { |subscriber| subscriber.call(payload) }
      end
    end
  end
end
