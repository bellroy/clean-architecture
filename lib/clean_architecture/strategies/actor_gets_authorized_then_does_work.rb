# frozen_string_literal: true

require 'dry/monads/all'
require 'clean_architecture/entities/failure_details'
require 'clean_architecture/interfaces/strategy'

module CleanArchitecture
  module Strategies
    class ActorGetsAuthorizedThenDoesWork
      extend Forwardable

      implements_interface Interfaces::Strategy

      def initialize(authorization_check, sub_strategy)
        @authorization_check = authorization_check
        @sub_strategy = sub_strategy
      end

      def_delegator :@sub_strategy, :parameters

      UNAUTHORIZED_FAILURE_DETAILS = Entities::FailureDetails.new(
        message: 'Unauthorized',
        other_properties: {},
        type: 'unauthorized'
      )

      def result
        @result ||= begin
          if @authorization_check.authorized?
            @sub_strategy.result
          else
            Dry::Monads::Failure(UNAUTHORIZED_FAILURE_DETAILS)
          end
        end
      end
    end
  end
end
