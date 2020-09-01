# frozen_string_literal: true

require 'catch_box/middleware'

module Mailgun
  module Tracking
    # Rack middleware to handle an HTTP POST to the callback URL when events occur with a message.
    #
    # @example
    #   use Mailgun::Tracking::Middleware
    class Middleware < ::CatchBox::Middleware
      # Initialize a Mailgun::Tracking::Middleware object.
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
