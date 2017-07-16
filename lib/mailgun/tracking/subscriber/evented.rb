module Mailgun
  module Tracking
    module Subscriber
      class Evented
        def initialize(name, callable)
          @name = name.to_sym
          @callable = callable
        end

        def call(payload)
          @callable.call(payload)
        end

        def subscribed_to?(name)
          @name == name.to_sym
        end
      end
    end
  end
end
