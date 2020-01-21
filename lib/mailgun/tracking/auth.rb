require 'openssl'

module Mailgun
  module Tracking
    class Auth
      def self.call(payload, **)
        new(payload).valid?
      end

      def initialize(payload)
        @payload = payload
      end

      def valid?
        signature['signature'] == \
          ::OpenSSL::HMAC.hexdigest(
            ::OpenSSL::Digest::SHA256.new,
            ::Mailgun::Tracking.api_key,
            data
          )
      end

      private

      def signature
        @signature ||= @payload.fetch('signature')
      end

      def data
        [signature['timestamp'], signature['token']].join
      end
    end
  end
end
