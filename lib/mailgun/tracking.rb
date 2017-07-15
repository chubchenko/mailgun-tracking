require 'mailgun/tracking/exceptions'
require 'mailgun/tracking/listener'
require 'mailgun/tracking/notifier'
require 'mailgun/tracking/rack'
require 'mailgun/tracking/signature'
require 'mailgun/tracking/subscriber_adapter'
require 'mailgun/tracking/version'
require 'mailgun/tracking/railtie' if defined? Rails

module Mailgun
  module Tracking
    DEFAULT_ENDPOINT = '/mailgun'.freeze

    class << self
      attr_accessor :api_key,
                    :endpoint

      def configure
        yield(self)
      end
    end

    self.endpoint = DEFAULT_ENDPOINT

    module_function

    def notifier
      @notifier ||= Notifier.new
    end
  end
end
