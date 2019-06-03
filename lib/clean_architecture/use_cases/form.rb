# frozen_string_literal: true

require 'active_model'
require 'clean_architecture/use_cases/errors'
require 'clean_architecture/entities/failure_details'
require 'dry/struct'
require 'dry/monads/try'
require 'dry/matcher/result_matcher'

module CleanArchitecture
  module UseCases
    class Form
      include ActiveModel::Conversion
      include Dry::Monads::Try::Mixin
      extend ActiveModel::Naming

      attr_reader :errors, :context

      def initialize(params: {}, context: {}, errors: UseCases::Errors.new(nil))
        @params = params.to_h.symbolize_keys
        @context = context
        @errors = errors
      end

      def persisted?
        false
      end

      # Attempts to create the parameter object returning a Dry::Monads::Result with either
      # the parameter object or an exception
      def to_parameter_object
        @to_parameter_object ||= begin
          use_case_class.params.with(context).call(parameter_object_hash)
        end
      end

      def with_errors(new_errors, override_params: nil)
        self.class.new(
          params: override_params || @params,
          context: @context,
          errors: ErrorsFactory.new(new_errors).manufacture
        )
      end

      def with_error_message(message, override_params: nil)
        new_errors = UseCases::Errors.new(nil)
        new_errors.add(:base, message)
        with_errors(new_errors, override_params: override_params)
      end

      def self.acts_as_form_for(use_case_class)
        attribute_names = use_case_class.params.rules.keys

        attribute_names.each do |attribute_name|
          define_method attribute_name do
            to_parameter_object.to_h[attribute_name]
          end
        end

        define_method :use_case_class do
          use_case_class
        end
      end

      def self.prepopulate_with(_object, _context)
        raise NotImplementedError, 'This form does not support prepopulation'
      end

      private

      def attempt_parameter_object_hash_creation
        errors.clear
        parameter_object_hash
      end

      # This can be overridden for forms where the params don't map perfectly
      # to the parameter object
      def parameter_object_hash
        @params
      end

      class ErrorsFactory
        def initialize(errors)
          @errors = errors
        end

        def manufacture
          if @errors.is_a?(UseCases::Errors)
            return @errors
          elsif @errors.is_a?(Entities::FailureDetails)
            return errors_from_failure_details
          elsif @errors.is_a?(String)
            return errors_from_string
          end

          raise ArgumentError, "Unable to handle errors of type: #{@errors.class}"
        end

        private

        def errors_from_failure_details
          errors = UseCases::Errors.new(nil)
          errors.add(:base, @errors.message)
          errors
        end

        def errors_from_string
          errors = UseCases::Errors.new(nil)
          errors.add(:base, @errors)
          errors
        end
      end
    end
  end
end
