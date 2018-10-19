# frozen_string_literal: true

require 'dry-matcher'

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
        when String
          Entities::FailureDetails.new(message: failure, other_properties: {}, type: 'error')
        when Entities::FailureDetails
          failure
        else
          raise 'Unexpected failure value - must be String or Entities::FailureDetails'
        end
      end
    end
  end
end
