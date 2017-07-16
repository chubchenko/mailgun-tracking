module Mailgun
  module Tracking
    module Event
      class Drop < Base
        def event
          :drop
        end

        def recipient; end

        def domain; end

        def message_headers; end

        def reason; end

        def code; end

        def description; end

        # Custom variables

        def timestamp; end

        def token; end

        def signature; end

        # attachment-x
      end
    end
  end
end
