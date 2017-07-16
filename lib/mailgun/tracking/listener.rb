module Mailgun
  module Tracking
    class Listener
      attr_reader :subscribers

      def initialize
        @subscribers = []
      end

      def add_subscriber(event, callable)
        @subscribers << Subscriber.for(event, callable)
      end

      def broadcast(event, payload)
        subscribers_for(event).each { |subscriber| subscriber.call(payload) }
      end

      private

      def subscribers_for(event)
        @subscribers.select { |subscriber| subscriber.subscribed_to?(event) }
      end
    end
  end
end
