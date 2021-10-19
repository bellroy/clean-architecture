# typed: strict
# frozen_string_literal: true

require 'dry/monads/all'
require 'clean_architecture/entities/failure_details'

module CleanArchitecture
  module Checks
    class Authorization
      extend T::Sig
      extend T::Helpers

      abstract!

      sig { returns(Dry::Monads::Result[Entities::FailureDetails, NilClass]) }
      def result
        if authorized?
          Dry::Monads::Success(nil)
        else
          failure_details = Entities::FailureDetails.new(
            message: failure_message,
            type: Entities::FailureType::Unauthorized
          )
          Dry::Monads::Failure(failure_details)
        end
      end

      protected

      sig { returns(String) }
      def failure_message
        'Unauthorized'
      end

      sig { abstract.returns(T::Boolean) }
      def authorized?; end
    end
  end
end
