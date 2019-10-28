# typed: true
# frozen_string_literal: true

require 'dry/monads/result'
require 'dry/validation'
require 'dry/matcher/result_matcher'
require 'clean_architecture/use_cases/errors'
require 'clean_architecture/use_cases/parameters'
require 'clean_architecture/use_cases/contract'
require 'clean_architecture/entities/failure_details'

module CleanArchitecture
  module UseCases
    class AbstractUseCase
      extend Forwardable

      @contract = nil

      def self.contract(base_contract = Contract)
        @contract ||= begin
          Class.new(base_contract, &Proc.new)
        end
      end

      def self.parameters(params)
        raise 'You must define a contract first' if @contract.nil?

        context = params.fetch(:context, {})
        Parameters.new(
          context,
          contract.new(context).call(params)
        )
      end

      def initialize(params)
        @params = params
      end

      def result
        raise NotImplementedError
      end

      private

      DEFAULT_FAILURE_TYPE = 'error'

      def fail_with_error_message(message, failure_type = DEFAULT_FAILURE_TYPE)
        new_errors = Errors.new(nil, failure_type)
        new_errors.add(:base, message)
        Dry::Monads::Failure(new_errors)
      end

      def result_of_validating_params
        @params.to_monad
      end

      def context(key)
        @params.context(key)
      end
    end
  end
end
