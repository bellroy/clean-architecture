# frozen_string_literal: true

require 'dry/monads/result'
require 'dry/validation'
require 'dry/matcher/result_matcher'
require 'clean_architecture/use_cases/errors'
require 'clean_architecture/entities/failure_details'

Dry::Validation.load_extensions(:monads)

module CleanArchitecture
  module UseCases
    class AbstractUseCase
      extend Forwardable

      @params = nil

      def self.params(base_schema = nil)
        @params ||= begin
          if base_schema
            Dry::Validation.Params(base_schema, &Proc.new)
          else
            Dry::Validation.Params(&Proc.new)
          end
        end
      end

      def initialize
        raise NotImplementedError
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

      INVALID_PARAMS_FAILURE_TYPE = 'expectation_failed'

      def result_of_validating_params(parameters)
        Dry::Matcher::ResultMatcher.call(parameters.to_monad) do |matcher|
          matcher.success { |valid_params| Dry::Monads::Success(valid_params) }

          matcher.failure do |validation_errors|
            new_errors = Errors.new(nil, INVALID_PARAMS_FAILURE_TYPE)
            validation_errors.keys.each do |invalid_attribute_key|
              validation_errors[invalid_attribute_key].each do |message|
                new_errors.add(invalid_attribute_key, message)
              end
            end
            Dry::Monads::Failure(new_errors)
          end
        end
      end
    end
  end
end
