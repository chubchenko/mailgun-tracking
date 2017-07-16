module Mailgun
  module Tracking
    module Event
      class Unsubscribe < Base
        def event
          :unsubscribed
        end

        def recipient; end

        def domain; end

        def ip; end

        def country; end

        def region; end

        def city; end

        def user_agent; end

        def device_type; end

        def client_type; end

        def client_name; end

        def client_os; end

        def campaign_id; end

        def campaign_name; end

        def tag; end

        def mailing_list; end

        # Custom variables

        def timestamp; end

        def signature; end
      end
    end
  end
end
