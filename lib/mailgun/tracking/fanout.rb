# frozen_string_literal: true

require 'catch_box/fanout'
require 'mailgun/tracking/auth'

module Mailgun
  module Tracking
    # It broadcast the payload to all callable based on event type. Also, there is an authenticity
    # of the webhook before each broadcast.
    class Fanout
      extend ::CatchBox::Fanout

      event 'event-data.event'

      auth ::Mailgun::Tracking::Auth
    end
  end
end
