# typed: true
# frozen_string_literal: true

require 'dry/monads/result'
require 'clean_architecture/use_cases/errors'

module CleanArchitecture
  module UseCases
    class Parameters
      include Dry::Monads::Result::Mixin
      extend Forwardable

      def initialize(context, dry_validation_result)
        @context = context
        @dry_validation_result = dry_validation_result
      end

      def context(key)
        @context.fetch(key)
      end

      def_delegators :@dry_validation_result,
                     :[]

      def to_monad
        @dry_validation_result.success? ? Success(@dry_validation_result.to_h) : Failure(errors)
      end

      INVALID_PARAMS_FAILURE_TYPE = 'expectation_failed'

      def errors
        new_errors = Errors.new(nil, INVALID_PARAMS_FAILURE_TYPE)
        @dry_validation_result.errors.to_h.each_pair do |invalid_attribute_key, error_messages|
          error_messages.each do |error_message|
            new_errors.add(invalid_attribute_key, error_message)
          end
        end
        new_errors
      end
    end
  end
end
