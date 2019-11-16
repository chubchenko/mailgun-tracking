# frozen_string_literal: true

require_relative 'tracking/configuration'
require_relative 'tracking/exceptions'
require_relative 'tracking/listener'
require_relative 'tracking/middleware'
require_relative 'tracking/notifier'
require_relative 'tracking/payload'
require_relative 'tracking/signature'
require_relative 'tracking/subscriber'
require_relative 'tracking/util'
require_relative 'tracking/version'
require_relative 'tracking/railtie' if defined?(Rails)
require_relative 'tracking/request'

# Module for interacting with the Mailgun.
module Mailgun
  # Namespace for classes and modules that handle Mailgun Webhooks.
  module Tracking
    module_function

    # Default way to setup Mailgun Tracking.
    #
    # @example
    #   Mailgun::Tracking.configure do |config|
    #     config.api_key = ENV['MAILGUN_API_KEY']
    #     config.endpoint = '/mailgun-tracking'
    #
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
    # @return [void]
    def configure
      yield(self)
    end

    # A Notifier instance.
    #
    # @return [Mailgun::Tracking::Notifier]
    def notifier
      @notifier ||= Notifier.new
    end

    # Delegate other missing methods to configuration.
    def method_missing(method_name, *arguments, &block)
      if Configuration.instance.respond_to?(method_name)
        Configuration.instance.public_send(method_name, *arguments, &block)
      else
        super
      end
    end

    # Replaces the Object.respond_to?() method.
    def respond_to_missing?(method_name, include_private = false)
      Configuration.instance.respond_to?(method_name) || super
    end
  end
end
