# frozen_string_literal: true

require 'dry-monads'

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

      def result
        @result ||= begin
          if @authorization_check.authorized?
            @sub_strategy.result
          else
            Dry::Monads::Failure('Unauthorized')
          end
        end
      end
    end
  end
end
