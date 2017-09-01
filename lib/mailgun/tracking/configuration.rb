require 'singleton'

module Mailgun
  module Tracking
    # Stores configuration information.
    class Configuration
      include Singleton

      DEFAULT_ENDPOINT = '/mailgun'.freeze

      # Mailgun API public key.
      #
      # @return [String]
      attr_accessor :api_key

      # Mailgun Webhook API endpoint.
      #
      # @return [String]
      attr_accessor :endpoint

      # Initializes a new Configuration object.
      def initialize
        @endpoint = DEFAULT_ENDPOINT
      end

      # Sets configuration information.
      #
      # @option options [String] :api_key Mailgun API public key.
      # @option options [String] :endpoint Mailgun Webhook API endpoint.
      #
      # @return [void]
      def configure(options = {})
        options.each_pair do |key, value|
          instance_variable_set("@#{key}", value)
        end
        yield(self) if block_given?
      end
    end
  end
end
