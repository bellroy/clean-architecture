# frozen_string_literal: true

require 'clean_architecture/entities/failure_details'
require 'dry-matcher'
require 'dry/monads/all'

module CleanArchitecture
  module Matchers
    class UseCaseResult
      def self.call(result, &block)
        new.matcher.call(result, &block)
      end

      def matcher
        Dry::Matcher.new(success: success_case, failure: failure_case)
      end

      private

      def success_case
        Dry::Matcher::Case.new(
          match: ->(value) { value.is_a?(Dry::Monads::Success) },
          resolve: ->(value) { value.value! }
        )
      end

      def failure_case
        Dry::Matcher::Case.new(
          match: ->(value) { value.is_a?(Dry::Monads::Failure) },
          resolve: ->(value) { resolve_failure_value(value) }
        )
      end

      def resolve_failure_value(value)
        failure = value.failure
        case failure
        when Array
          Entities::FailureDetails.from_array(failure)
        when String
          Entities::FailureDetails.from_string(failure)
        when Entities::FailureDetails
          failure
        else
          type_list = [Array, String, Entities::FailureDetails].map(&:to_s).join(' or ')
          raise ArgumentError, "Unexpected failure value - must be #{type_list}"
        end
      end
    end
  end
end
