module Mailgun
  module Tracking
    class Notifier
      def initialize(listener = Listener.new)
        @listener ||= listener
      end

      def subscribe(name, callable = Proc.new)
        listener.add_subscriber(name, SubscriberAdapter.call(callable))
      end

      def all(callable = Proc.new)
        listener.add_subscriber(nil, SubscriberAdapter.call(callable))
      end

      def broadcast(name, payload)
        Signature.verify!(payload)
        listener.broadcast(name, payload)
      end

      private

      attr_reader :listener
    end
  end
end
