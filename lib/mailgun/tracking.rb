require 'mailgun/tracking/exceptions'
require 'mailgun/tracking/listener'
require 'mailgun/tracking/rack'
require 'mailgun/tracking/signature'
require 'mailgun/tracking/version'

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

    def subscribe(event, &block)
      listener.add_subscriber(event, &block)
    end

    def broadcast(event, payload)
      Signature.verify!(payload)
      listener.broadcast(event, payload)
    end

    def clear_cached_variables
      @listener = nil
    end

    private

    module_function

    def listener
      @listener ||= Listener.new
    end
  end
end
