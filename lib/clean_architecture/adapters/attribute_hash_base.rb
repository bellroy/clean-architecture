# typed: strict
# frozen_string_literal: true

require 'time'

# frozen_string_literal: true

module CleanArchitecture
  module Adapters
    # Allows you to implement an interface around a hash with type safety
    class AttributeHashBase
      # Error raised if an expected value isn't present or isn't the type we expect
      class EmptyOrIncorrectAttributeTypeError < StandardError; end

      extend T::Sig

      sig { params(attribute_hash: T::Hash[Object, Object]).void }
      def initialize(attribute_hash)
        @attribute_hash = attribute_hash
      end

      protected

      sig { returns(T::Hash[Object, Object]) }
      attr_reader :attribute_hash

      private

      sig { params(default: Object, block: T.proc.returns(T.nilable(Object))).returns(Object) }
      def ensured_value(default:, &block)
        block.call || default
      rescue EmptyOrIncorrectAttributeTypeError, TypeError, ArgumentError
        default
      end

      sig { params(block: T.proc.returns(T.nilable(Object))).returns(T.nilable(Object)) }
      def maybe_value(&block)
        ensured_value(default: nil) { block.call }
      end

      sig { params(key: Object).returns(T::Boolean) }
      def boolean_value(key)
        raw_value(key).to_s == 'true'
      end

      sig { params(key: Object, adapter_class: Class).returns(Object) }
      def complex_object_value(key, adapter_class)
        T.unsafe(adapter_class).new(raw_value(key))
      end

      sig { params(key: Object, adapter_class: Class, additional_arguments: Object).returns(T::Array[Object]) }
      def complex_object_list_value(key, adapter_class, additional_arguments = [])
        array = maybe_raw_value(key) || []
        unless array.is_a?(Array)
          raise EmptyOrIncorrectAttributeTypeError, "value at key #{key} is not an array!"
        end
        array.map { |array_entry| T.unsafe(adapter_class).new(array_entry, *additional_arguments) }
      end

      sig { params(key: Object).returns(Float) }
      def currency_value(key)
        float_value(key).round(2).to_f
      end

      sig { params(key: Object).returns(Date) }
      def date_value(key)
        Date.parse(raw_value(key).to_s)
      end

      sig { params(key: Object).returns(Time) }
      def time_value(key)
        Time.parse(raw_value(key).to_s)
      end

      sig { params(key: Object).returns(Time) }
      def date_time_value(key)
        Time.strptime(raw_value(key).to_s, '%Y-%m-%dT%H:%M:%S.%L%z')
      end

      sig { params(key: Object).returns(Float) }
      def float_value(key)
        raw_value(key).to_s.to_f
      end

      sig { params(key: Object).returns(Integer) }
      def int_value(key)
        raw_value(key).to_s.to_i
      end

      sig { params(key: Object).returns(Regexp) }
      def regex_value(key)
        raw_pattern = raw_value(key)
        return raw_pattern if raw_pattern.is_a?(Regexp)
        /#{raw_pattern}/
      end

      sig { params(key: Object, adapter_class: Class).returns(T.nilable(Object)) }
      def maybe_complex_object_value(key, adapter_class)
        maybe_value { complex_object_value(key, adapter_class) }
      end

      sig { params(key: Object).returns(T.nilable(Date)) }
      def maybe_date_value(key)
        T.cast(maybe_value { date_value(key) }, T.nilable(Date))
      end

      sig { params(key: Object).returns(T.nilable(Time)) }
      def maybe_time_value(key)
        T.cast(maybe_value { time_value(key) }, T.nilable(Time))
      end

      sig { params(key: Object).returns(T.nilable(Time)) }
      def maybe_date_time_value(key)
        T.cast(maybe_value { date_time_value(key) }, T.nilable(Time))
      end

      sig { params(key: Object).returns(T.nilable(Integer)) }
      def maybe_int_value(key)
        T.cast(maybe_value { int_value(key) }, T.nilable(Integer))
      end

      sig { params(key: Object).returns(T.nilable(Float)) }
      def maybe_float_value(key)
        T.cast(maybe_value { float_value(key) }, T.nilable(Float))
      end

      sig { params(key: Object).returns(T.nilable(String)) }
      def maybe_string_value(key)
        T.cast(maybe_value { string_value(key) }, T.nilable(String))
      end

      sig { params(key: Object).returns(String) }
      def string_value(key)
        raw_value(key).to_s
      end

      sig { params(key: Object).returns(Symbol) }
      def symbol_value(key)
        string_value(key).to_sym
      end

      sig { params(key: Object).returns(T.nilable(Object)) }
      def maybe_raw_value(key)
        maybe_value { raw_value(key) }
      end

      EMPTY_VALUES = T.let([nil, ''].freeze, T::Array[Object])

      sig { params(key: Object).returns(Object) }
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
