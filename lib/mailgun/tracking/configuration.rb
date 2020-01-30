# frozen_string_literal: true

require 'singleton'

module Mailgun
  module Tracking
    # Configuration for Mailgun Tracking.
    class Configuration
      include ::Singleton

      DEFAULT_ENDPOINT = '/mailgun'

      # @return [String] Mailgun API public key.
      attr_accessor :api_key

      # @return [String] Mailgun callback URL.
      attr_accessor :endpoint

      # Initialize a Mailgun::Tracking::Configuration object.
      def initialize
        @endpoint = DEFAULT_ENDPOINT
      end
    end
  end
end
