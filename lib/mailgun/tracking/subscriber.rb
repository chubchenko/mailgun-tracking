# frozen_string_literal: true

require 'mailgun/tracking/subscriber/all_messages'
require 'mailgun/tracking/subscriber/evented'

module Mailgun
  module Tracking
    # Namespace for classes that wraps subscribers.
    module Subscriber
      # Determines the type of subscription.
      #
      # @param name [Symbol, String] The name of event.
      # @param callable [Proc, Class] The callable object.
      #   The callable objects should respond to call.
      #
      # @return [Mailgun::Tracking::Subscriber::Evented, Mailgun::Tracking::Subscriber::AllMessages]
      def self.for(name, callable)
        if name
          Evented.new(name, callable)
        else
          AllMessages.new(callable)
        end
      end
    end
  end
end
