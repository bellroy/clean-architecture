# frozen_string_literal: true

require 'dry/monads/all'
require 'clean_architecture/entities/failure_details'

module CleanArchitecture
  module Checks
    class Authorization
      extend Forwardable

      def result
        if authorized?
          Dry::Monads::Success(true)
        else
          failure_details = Entities::FailureDetails.new(
            message: failure_message,
            other_properties: {},
            type: 'unauthorized'
          )
          Dry::Monads::Failure(failure_details)
        end
      end

      protected

      def failure_message
        'Unauthorized'
      end

      def authorized?
        raise NotImplementedError
      end
    end
  end
end
