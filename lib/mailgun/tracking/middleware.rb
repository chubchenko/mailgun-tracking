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
      #
      # @param fanout [Mailgun::Tracking::Fanout]
      # @param endpoint [String] Mailgun callback URL.
      def initialize(app, fanout: ::Mailgun::Tracking::Fanout, endpoint: ::Mailgun::Tracking.endpoint)
        super
      end
    end
  end
end
