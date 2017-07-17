module Mailgun
  module Tracking
    module Event
      class Bounce < Base
        def event
          :bounced
        end

        def recipient; end

        def domain; end

        def message_headers; end

        def code; end

        def error; end

        def notification; end

        def campaign_id; end

        def campaign_name; end

        def tag; end

        def mailing_list; end

        # Custom variables

        def timestamp; end

        def token; end

        def signature; end

        # attachment-x
      end
    end
  end
end
