# typed: strict
# frozen_string_literal: true

require 'clean_architecture/entities/failure_details'
require 'dry-matcher'
require 'dry/monads/all'

module CleanArchitecture
  module Matchers
    class UseCaseResult
      extend T::Sig

      sig { params(result: Dry::Monads::Result[Entities::FailureDetails, T.untyped], block: T.untyped).returns(T.untyped) }
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
          resolve: ->(value) { value.failure }
        )
      end
    end
  end
end
