module Mailgun
  module Tracking
    class Notifier
      def initialize(listener = Listener.new)
        @listener ||= listener
      end

      def subscribe(event, callable = Proc.new)
        listener.add_subscriber(event, callable)
      end

      def all(callable = Proc.new)
        listener.add_subscriber(nil, callable)
      end

      def broadcast(event, payload)
        Signature.verify!(payload)
        listener.broadcast(event, payload)
      end

      private

      attr_reader :listener
    end
  end
end
