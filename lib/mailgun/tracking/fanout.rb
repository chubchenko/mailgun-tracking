# frozen_string_literal: true

require 'catch_box/fanout'
require 'mailgun/tracking/auth'

module Mailgun
  module Tracking
    class Fanout
      extend ::CatchBox::Fanout

      event 'event-data.event'

      auth ::Mailgun::Tracking::Auth
    end
  end
end
