module Mailgun
  module Tracking
    module Subscriber
      # Wraps the subscriber for events.
      class AllMessages
        # Initializes a new AllMessages object.
        #
        # @param callable [Proc, Class] The callable object.
        #   The callable objects should respond to call.
        #
        # @return [Mailgun::Tracking::Subscriber::AllMessages]
        def initialize(callable)
          @callable = callable
        end

        # Invokes the callable object.
        #
        # @param payload [Hash] The response parameters.
        #
        # @return [void]
        def call(payload)
          @callable.call(payload)
        end

        # Checks if a callable object is a subscribed to the specified event.
        #
        # @return [Boolean]
        #   Always returns true.
        def subscribed_to?(*)
          true
        end
      end
    end
  end
end
