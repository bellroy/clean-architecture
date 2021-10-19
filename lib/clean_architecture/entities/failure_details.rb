# typed: strict
# frozen_string_literal: true

module CleanArchitecture
  module Entities
    class FailureType < T::Enum
      enums do
        Error = new('internal_server_error')
        ExpectationFailed = new('expectation_failed')
        NotFound = new('not_found')
        Unauthorized = new('unauthorized')
        UnprocessableEntity = new('unprocessable_entity')
      end
    end

    class FailureDetails < T::Struct
      extend T::Sig

      include T::Struct::ActsAsComparable

      const :type, FailureType
      const :message, String

      sig { params(array: T::Array[Object]).returns(FailureDetails) }
      def self.from_array(array)
        new(
          message: array.map(&:to_s).join(', '),
          type: FailureType::Error
        )
      end

      sig { params(string: String).returns(FailureDetails) }
      def self.from_string(string)
        new(
          message: string,
          type: FailureType::Error
        )
      end
    end
  end
end
