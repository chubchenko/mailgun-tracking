# frozen_string_literal: true

require 'mailgun/tracking/configuration'
require 'mailgun/tracking/middleware'
require 'mailgun/tracking/version'
require 'mailgun/tracking/railtie' if defined?(::Rails)
require 'mailgun/tracking/fanout'

module Mailgun
  # The namespace for classes and modules that handle Mailgun webhooks.
  module Tracking
    module_function

    # The default way to set up Mailgun Tracking.
    #
    # @yield [self] block yields itself.
    #
    # @example
    #   Mailgun::Tracking.configure do |config|
    #     config.api_key = ENV['MAILGUN_API_KEY']
    #
    #     config.endpoint = '/mailgun-tracking'
    #
    #     config.on 'delivered' do |payload|
    #       # Do something with the incoming data.
    #     end
    #
    #     # The object should respond to #call
    #     config.on 'bounced', Bounced.new
    #
    #     config.all do |payload|
    #       # Do something with the incoming data.
    #     end
    #   end
    def configure
      yield(self)
    end

    # Subscribe to an event.
    #
    # @param event [Symbol, String] the event identifier.
    # @param callable [#call] the event handler.
    #
    # @example
    #   Mailgun::Tracking.configure do |config|
    #     config.on 'delivered' do |payload|
    #       # Do something with the incoming data.
    #     end
    #
    #     # The object should respond to #call
    #     config.on 'bounced', Bounced.new
    #   end
    def on(event, callable = nil, &block)
      ::Mailgun::Tracking::Fanout.on(
        event.to_s.dup.freeze,
        callable || block
      )
    end

    # Subscribe to all events.
    #
    # @param callable [#call] the event handler.
    #
    # @example
    #   Mailgun::Tracking.configure do |config|
    #     config.all do |payload|
    #       # Do something with the incoming data.
    #     end
    #
    #     # The object should respond to #call
    #     config.all, All.new
    #   end
    def all(callable = nil, &block)
      ::Mailgun::Tracking::Fanout.all(
        callable || block
      )
    end

    # Delegate any missing method call to the configuration.
    def method_missing(method_name, *arguments, &block)
      return super unless configuration.respond_to?(method_name)

      configuration.public_send(method_name, *arguments, &block)
    end

    # Replace the Object.respond_to?() method.
    def respond_to_missing?(method_name, include_private = false)
      configuration.respond_to?(method_name) || super
    end

    # @return [Mailgun::Tracking::Configuration]
    def configuration
      ::Mailgun::Tracking::Configuration.instance
    end

    private_class_method :configuration
  end
end
