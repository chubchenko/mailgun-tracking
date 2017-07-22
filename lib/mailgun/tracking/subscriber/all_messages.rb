module Mailgun
  module Tracking
    module Subscriber
      class AllMessages
        def initialize(callable)
          @callable = callable
        end

        def call(payload)
          @callable.call(payload)
        end

        def subscribed_to?(*)
          true
        end
      end
    end
  end
end
