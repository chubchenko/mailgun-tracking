require 'openssl'

module Mailgun
  module Tracking
    class Signature
      def self.verify!(payload)
        signature = new(payload)
        raise InvalidSignature unless signature.valid?
        true
      end

      def initialize(payload)
        @token = payload.fetch('token')
        @timestamp = payload.fetch('timestamp')
        @signature = payload.fetch('signature')
      end

      def valid?
        @signature == OpenSSL::HMAC.hexdigest(digest, Mailgun::Tracking.api_key, data)
      end

      private

      def digest
        OpenSSL::Digest::SHA256.new
      end

      def data
        [@timestamp, @token].join
      end
    end
  end
end
