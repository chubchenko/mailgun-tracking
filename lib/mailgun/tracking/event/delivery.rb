module Mailgun
  module Tracking
    module Event
      class Delivery < Base
        def event
          :delivered
        end

        def recipient; end

        def domain; end

        def message_headers; end

        def message_id; end

        # Custom variables

        def timestamp; end

        def token; end

        def signature; end
      end
    end
  end
end
