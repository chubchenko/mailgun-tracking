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
      end

      # Returns a value of the original payload with the given key.
      #
      # @param key [String]
      #
      # @return a value of the original payload.
      def [](key)
        @original[key]
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
