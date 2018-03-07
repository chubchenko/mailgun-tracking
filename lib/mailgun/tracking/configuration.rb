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
    end
  end
end
