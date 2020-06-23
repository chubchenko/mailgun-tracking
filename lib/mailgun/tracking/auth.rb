# frozen_string_literal: true

require 'openssl'

module Mailgun
  module Tracking
    # Used to ensure the authenticity of event requests.
    class Auth
      SIGNATURE = 'signature'

      # @param payload [Hash] webhook payload.
      #
      # @return [Boolean]
      def self.call(payload, _env = nil)
        new(payload).valid?
      end

      # Initialize a Mailgun::Tracking::Auth object.
      #
      # @param payload [Hash] webhook payload.
      #
      # @return [Mailgun::Tracking::Auth]
      def initialize(payload)
        @payload = payload
      end

      # Compare the resulting hexdigest to the signature.
      #
      # @return [Boolean]
      def valid?
        @payload.dig(SIGNATURE, SIGNATURE) == \
          ::OpenSSL::HMAC.hexdigest(
            ::OpenSSL::Digest.new('SHA256'),
            ::Mailgun::Tracking.api_key,
            data
          )
      end

      private

      # Concatenate timestamp and token values.
      #
      # @return [String]
      def data
        [
          @payload.dig(SIGNATURE, 'timestamp'),
          @payload.dig(SIGNATURE, 'token')
        ].join
      end
    end
  end
end
