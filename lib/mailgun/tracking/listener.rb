# frozen_string_literal: true

module Mailgun
  module Tracking
    # Represents a mechanism for event listeners to subscribe to events and for event broadcasts.
    class Listener
      # List of subscribers.
      #
      # @return [Array<Mailgun::Tracking::Subscriber::AllMessages, Mailgun::Tracking::Subscriber::Evented>]
      attr_reader :subscribers

      # Initializes a new Listener object.
      #
      # @return [Mailgun::Tracking::Listener]
      def initialize
        @subscribers = []
      end

      # Adds a subscriber to the list of subscribers for the specified event.
      #
      # @param event [Symbol, String] The name of event.
      # @param callable [Proc, Class] The listener of event.
      #   The callable objects should respond to call.
      #
      # @return [Array<Mailgun::Tracking::Subscriber::AllMessages, Mailgun::Tracking::Subscriber::Evented>]
      #   The list of subscribers.
      def add_subscriber(event, callable)
        @subscribers << Subscriber.for(event, callable)
      end

      # Broadcasts an event to the subscribers.
      #
      # @param event [String] The name of event.
      # @param payload [Hash] The response parameters.
      #
      # @return [Array<Mailgun::Tracking::Subscriber::AllMessages, Mailgun::Tracking::Subscriber::Evented>]
      #   The list of subscribers.
      def broadcast(event, payload)
        subscribers_for(event).each { |subscriber| subscriber.call(payload) }
      end

      private

      # Selects the subscribers for the specified event.
      #
      # @param event [String] The name of event.
      #
      # @return [Array<Mailgun::Tracking::Subscriber::AllMessages, Mailgun::Tracking::Subscriber::Evented>]
      #   The list of subscribers.
      def subscribers_for(event)
        @subscribers.select { |subscriber| subscriber.subscribed_to?(event) }
      end
    end
  end
end
