# frozen_string_literal: true

module Mailgun
  module Tracking
    # Wraps the {Listener} which gives a friendlier way to subscribe or broadcast.
    class Notifier
      # Initializes a new Notifier object.
      #
      # @param listener [Mailgun::Tracking::Listener] Event listener.
      #
      # @return [Mailgun::Tracking::Notifier]
      def initialize(listener = Listener.new)
        @listener = listener
      end

      # Returns true if there is  at least one subscriber.
      #
      # @return [Boolean]
      def empty?
        listener.subscribers.empty?
      end

      # Adds subscriber for the specified event.
      #
      # @param event [Symbol, String] The name of event.
      # @param callable [Proc, Class] The listener of event.
      #   The callable objects should respond to call.
      #
      # @return [NilClass]
      def subscribe(event, callable = Proc.new)
        listener.add_subscriber(event, callable)
      end

      # Adds a subscriber for all events.
      #
      # @param callable [Proc, Class] The listener of event.
      #   The callable objects should respond to call.
      #
      # @return [NilClass]
      def all(callable = Proc.new)
        listener.add_subscriber(nil, callable)
      end

      # Broadcasts parameters to event subscribers.
      #
      # @param event [String] The name of event.
      # @param payload [Hash] The response parameters.
      #
      # @return [NilClass]
      def broadcast(event, payload)
        Signature.verify!(payload)
        listener.broadcast(event, payload.body)
      end

      private

      # @return [Mailgun::Tracking::Listener]
      attr_reader :listener
    end
  end
end
