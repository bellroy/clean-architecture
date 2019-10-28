# typed: true
# frozen_string_literal: true

require 'time'

# frozen_string_literal: true

module CleanArchitecture
  module Adapters
    # Allows you to implement an interface around a hash with type safety
    class AttributeHashBase
      # Error raised if an expected value isn't present or isn't the type we expect
      class EmptyOrIncorrectAttributeTypeError < StandardError; end

      def initialize(attribute_hash)
        @attribute_hash = attribute_hash
      end

      protected

      attr_reader :attribute_hash

      private

      def ensured_value(default:)
        yield
      rescue EmptyOrIncorrectAttributeTypeError, TypeError, ArgumentError
        default
      end

      def maybe_value
        ensured_value(default: nil) { yield }
      end

      def boolean_value(key)
        raw_value(key).to_s == 'true'
      end

      def complex_object_value(key, adapter_class)
        adapter_class.new(raw_value(key))
      end

      def complex_object_list_value(key, adapter_class, additional_arguments = [])
        array = maybe_raw_value(key) || []
        unless array.is_a?(Array)
          raise EmptyOrIncorrectAttributeTypeError, "value at key #{key} is not an array!"
        end
        array.map { |array_entry| adapter_class.new(array_entry, *additional_arguments) }
      end

      def currency_value(key)
        float_value(key).round(2)
      end

      def date_value(key)
        Date.parse(raw_value(key))
      end

      def time_value(key)
        Time.parse(raw_value(key))
      end

      def date_time_value(key)
        Time.strptime(raw_value(key), '%Y-%m-%dT%H:%M:%S.%L%z')
      end

      def float_value(key)
        raw_value(key).to_f
      end

      def int_value(key)
        raw_value(key).to_i
      end

      def regex_value(key)
        raw_pattern = raw_value(key)
        return raw_pattern if raw_pattern.is_a?(Regexp)
        /#{raw_pattern}/
      end

      def maybe_complex_object_value(key, adapter_class)
        maybe_value { complex_object_value(key, adapter_class) }
      end

      def maybe_date_value(key)
        maybe_value { date_value(key) }
      end

      def maybe_time_value(key)
        maybe_value { time_value(key) }
      end

      def maybe_date_time_value(key)
        maybe_value { date_time_value(key) }
      end

      def maybe_int_value(key)
        maybe_value { int_value(key) }
      end

      def maybe_float_value(key)
        maybe_value { float_value(key) }
      end

      def maybe_string_value(key)
        maybe_value { string_value(key) }
      end

      def string_value(key)
        raw_value(key).to_s
      end

      def symbol_value(key)
        string_value(key).to_sym
      end

      def maybe_raw_value(key)
        maybe_value { raw_value(key) }
      end

      EMPTY_VALUES = [nil, ''].freeze

      def raw_value(key)
        value = @attribute_hash[key]
        if EMPTY_VALUES.include?(value)
          raise EmptyOrIncorrectAttributeTypeError, "value at key #{key} is empty!"
        end
        value
      end

      private_constant :EMPTY_VALUES
    end
  end
end
