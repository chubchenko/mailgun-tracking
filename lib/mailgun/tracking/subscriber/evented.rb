module Mailgun
  module Tracking
    module Subscriber
      # Wraps the evented subscriber.
      class Evented
        # Initializes a new Evented object.
        #
        # @param name [Symbol, String] The name of event.
        # @param callable [Proc, Class] The callable object.
        #   The callable objects should respond to call.
        #
        # @return [Mailgun::Tracking::Subscriber::Evented]
        def initialize(name, callable)
          @name = name.to_sym
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
        # @param name [String] The name of event.
        #
        # @return [Boolean]
        def subscribed_to?(name)
          @name == name.to_sym
        end
      end
    end
  end
end
