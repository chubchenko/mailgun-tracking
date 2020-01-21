# frozen_string_literal: true

require 'singleton'

module Mailgun
  module Tracking
    class Configuration
      include ::Singleton

      DEFAULT_ENDPOINT = '/mailgun'

      attr_accessor :api_key

      attr_accessor :endpoint

      def initialize
        @endpoint = DEFAULT_ENDPOINT
      end
    end
  end
end
