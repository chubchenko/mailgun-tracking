# frozen_string_literal: true

module Mailgun
  module Tracking
    # The module which hold version data.
    module Version
      module_function

      KEYS = %i[major minor patch].freeze
      DOT = '.'

      # Major version.
      #
      # @return [Integer]
      def major
        3
      end

      # Minor version.
      #
      # @return [Integer]
      def minor
        0
      end

      # Patch version.
      #
      # @return [Integer]
      def patch
        0
      end

      # Return a hash representation of version.
      #
      # @return [Hash]
      def to_h
        ::Hash[KEYS.zip(to_a)]
      end

      # Return an array representation of version.
      #
      # @return [Array]
      def to_a
        [major, minor, patch]
      end

      # Return a string representation of version.
      #
      # @return [String]
      def to_s
        to_a.join(DOT)
      end
    end
  end
end
