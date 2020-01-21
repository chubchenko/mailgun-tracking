# frozen_string_literal: true

module Mailgun
  module Tracking
    module Version
      module_function

      KEYS = %i[major minor patch].freeze

      def major
        2
      end

      def minor
        0
      end

      def patch
        0
      end

      def to_h
        ::Hash[KEYS.zip(to_a)]
      end

      def to_a
        [major, minor, patch]
      end

      def to_s
        to_a.join('.')
      end
    end
  end
end
