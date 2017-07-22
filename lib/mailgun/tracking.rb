require 'mailgun/tracking/exceptions'
require 'mailgun/tracking/listener'
require 'mailgun/tracking/middleware'
require 'mailgun/tracking/notifier'
require 'mailgun/tracking/signature'
require 'mailgun/tracking/subscriber'
require 'mailgun/tracking/version'
require 'mailgun/tracking/railtie' if defined?(Rails)

# Module for interacting with the Mailgun.
module Mailgun
  # Namespace for classes and modules that handle Mailgun Webhooks.
  module Tracking
    DEFAULT_ENDPOINT = '/mailgun'.freeze

    class << self
      # Mailgun API public key.
      #
      # @return [String]
      attr_accessor :api_key

      # Mailgun Webhook API endpoint
      #
      # @return [String]
      attr_accessor :endpoint

      # Default way to setup Mailgun Tracking.
      # @example
      #   Mailgun::Tracking.configure do |config|
      #     config.api_key = ENV['MAILGUN_API_KEY']
      #     config.endpoint = '/mailgun-tracking'
      #   end
      def configure
        yield(self)
      end
    end

    self.endpoint = DEFAULT_ENDPOINT

    module_function

    # A Notifier instance.
    # @example
    #   Mailgun::Tracking.configure do |config|
    #     config.notifier.subscribe :delivered do |payload|
    #       # Do something with the incoming data.
    #     end
    #
    #     config.notifier.subscribe :bounced, Bounced.new
    #
    #     config.notifier.all do |payload|
    #       # Handle all event types.
    #     end
    #   end
    #
    # @return [Mailgun::Tracking::Notifier]
    def notifier
      @notifier ||= Notifier.new
    end
  end
end
