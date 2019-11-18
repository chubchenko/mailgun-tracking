# frozen_string_literal: true

require 'set'

module Mailgun
  module Tracking
    # Payload object.
    class Payload
      TRY_TO_HASH = lambda do |value|
        return if value.nil?

        value.respond_to?(:to_hash) ? value.to_hash : value
      end.freeze

      # Initializes a new Payload object.
      #
      # @param values [Hash]
      #
      # @return [Mailgun::Tracking::Payload]
      def initialize(values = {})
        @values = Util.normalize(values)

        @values.each do |key, value|
          define_instance_methods([key], values) unless __metaclass__.method_defined?(key)
          @values[key] = Util.convert_to_payload_object(value)
        end
      end

      # Returns a value of the payload with the given key.
      #
      # @param key [String]
      #
      # @return a value of the payload.
      def [](key)
        @values[key]
      end

      # @return [Boolean]
      def ==(other)
        return false unless other.is_a?(Payload)

        values == other.values
      end

      alias eql? ==

      # @return [Integer] The object's hash value (for equality checking)
      def hash
        values.hash
      end

      # @return [Hash] Recursively convert payload objects to the hash.
      def to_hash
        @values.each_with_object({}) do |(key, value), memo|
          memo[key] =
            case value
            when Array
              value.map(&TRY_TO_HASH)
            else
              TRY_TO_HASH.call(value)
            end
        end
      end

      # @return [String] The string representation of the payload.
      def to_s
        JSON.pretty_generate(to_hash)
      end

      private

      # @return [Class]
      def __metaclass__
        class << self
          self
        end
      end

      # @return [void]
      def define_instance_methods(keys, values)
        __metaclass__.instance_eval do
          keys.each do |key|
            define_method(key) { @values[key] }
            next unless [FalseClass, TrueClass].include?(values[key].class)

            define_method(:"#{key}?") { @values[key] }
          end
        end
      end

      protected

      attr_reader :values
    end
  end
end
