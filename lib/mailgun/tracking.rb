# frozen_string_literal: true

require 'mailgun/tracking/configuration'
require 'mailgun/tracking/middleware'
require 'mailgun/tracking/version'
require 'mailgun/tracking/railtie' if defined?(::Rails)
require 'mailgun/tracking/fanout'

module Mailgun
  module Tracking
    module_function

    def configure
      yield(self)
    end

    def on(event, callable = ::Proc.new)
      ::Mailgun::Tracking::Fanout.on(
        event.to_s.dup.freeze,
        callable
      )
    end

    def all(callable = ::Proc.new)
      ::Mailgun::Tracking::Fanout.all(
        callable
      )
    end

    def method_missing(method_name, *arguments, &block)
      if configuration.respond_to?(method_name)
        configuration.public_send(method_name, *arguments, &block)
      else
        super
      end
    end

    def respond_to_missing?(method_name, include_private = false)
      configuration.respond_to?(method_name) || super
    end

    def configuration
      ::Mailgun::Tracking::Configuration.instance
    end

    private_class_method :configuration
  end
end
