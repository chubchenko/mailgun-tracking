# frozen_string_literal: true

require 'openssl'

module Mailgun
  module Tracking
    # A Mailgun::Tracking::Signature object is used to verify the signature.
    class Signature
      # Verify the signature of the response parameters.
      #
      # @param payload [Hash]
      # @raise [InvalidSignature] Error raised when signature is invalid.
      #
      # @return [Boolean]
      #   Always returns true.
      def self.verify!(payload)
        signature = new(payload)
        raise InvalidSignature unless signature.valid?

        true
      end

      # Initializes a new Signature object.
      #
      # @param payload [Hash]
      #
      # @return [Mailgun::Tracking::Signature]
      def initialize(payload)
        @payload = payload
      end

      # @return [Boolean]
      def valid?
        @payload.signature == OpenSSL::HMAC.hexdigest(OpenSSL::Digest::SHA256.new, Configuration.instance.api_key, data)
      end

      private

      # Joins the timestamp and the response token.
      #
      # @return [String]
      def data
        [@payload.timestamp, @payload.token].join
      end
    end
  end
end
