# frozen_string_literal: true

require 'set'

module Mailgun
  module Tracking
    # Payload object.
    class Payload
      # Initializes a new Payload object.
      #
      # @param options [Hash]
      #
      # @return [Mailgun::Tracking::Payload]
      def initialize(options = {})
        @options = Util.normalize(options)
        @original = options

        define_instance_methods(Set.new(@options.keys), @options)

        @options.each do |k, v|
          @options[k] = Util.convert_to_payload_object(v)
        end
      end

      # Returns a value of the original payload with the given key.
      #
      # @param key [String]
      #
      # @return a value of the original payload.
      def [](key)
        @original[key]
      end

      def to_s
        JSON.pretty_generate(to_hash)
      end

      def to_hash
        maybe_to_hash = lambda do |value|
          return nil if value.nil?

          value.respond_to?(:to_hash) ? value.to_hash : value
        end

        @options.each_with_object({}) do |(key, value), acc|
          acc[key] = case value
                     when Array
                       value.map(&maybe_to_hash)
                     else
                       maybe_to_hash.call(value)
                     end
        end
      end

      private

      # @return [Class]
      def __metaclass__
        class << self
          self
        end
      end

      # @return [void]
      def define_instance_methods(keys, options)
        __metaclass__.instance_eval do
          keys.each do |key|
            define_method(key) { @options[key] }
            next unless [FalseClass, TrueClass].include?(options[key].class)

            define_method(:"#{key}?") { @options[key] }
          end
        end
      end
    end
  end
end
