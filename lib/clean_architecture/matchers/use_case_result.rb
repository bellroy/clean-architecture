# typed: strict
# frozen_string_literal: true

require 'clean_architecture/entities/failure_details'
require 'dry-matcher'
require 'dry/monads/all'

module CleanArchitecture
  module Matchers
    class UseCaseResult
      extend T::Sig

      sig { params(result: Dry::Monads::Result[T.any(T::Array[Object], String, Entities::FailureDetails), T.untyped], block: T.untyped).returns(T.untyped) }
      def self.call(result, &block)
        new.matcher.call(result, &block)
      end

      sig {returns(Dry::Matcher)}
      def matcher
        Dry::Matcher.new(success: success_case, failure: failure_case)
      end

      private

      sig { returns(Dry::Matcher::Case) }
      def success_case
        Dry::Matcher::Case.new(
          match: ->(value) { value.is_a?(Dry::Monads::Success) },
          resolve: ->(value) { value.value! }
        )
      end

      sig { returns(Dry::Matcher::Case) }
      def failure_case
        Dry::Matcher::Case.new(
          match: ->(value) { value.is_a?(Dry::Monads::Failure) },
          resolve: ->(value) { resolve_failure_value(value) }
        )
      end

      sig { params(value: Dry::Monads::Result[T.any(T::Array[Object], String, Entities::FailureDetails), T.untyped]).returns(Entities::FailureDetails) }
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
          T.absurd(failure)
        end
      end
    end
  end
end
