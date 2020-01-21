# frozen_string_literal: true

require 'catch_box/middleware'

module Mailgun
  module Tracking
    class Middleware < ::CatchBox::Middleware
      def initialize(app)
        super(
          app,
          fanout: ::Mailgun::Tracking::Fanout,
          endpoint: ::Mailgun::Tracking.endpoint
        )
      end
    end
  end
end
