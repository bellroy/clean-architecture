# frozen_string_literal: true

require 'dry-monads'
require 'dry/matcher/result_matcher'
require 'duckface'
require 'clean_architecture/interfaces/use_case_history_entry'

module CleanArchitecture
  module Entities
    class UseCaseHistoryEntry
      implements_interface Interfaces::UseCaseHistoryEntry
      extend Forwardable

      def initialize(use_case_class, use_case_parameters, use_case_result, use_case_target)
        @use_case_class = use_case_class
        @use_case_parameters = use_case_parameters
        @use_case_result = use_case_result
        @use_case_target = use_case_target
      end

      def extra_parameters_hash
        @use_case_parameters.extra_parameters_hash
      end

      def failure_messages
        Dry::Matcher::ResultMatcher.call(@use_case_result) do |matcher|
          matcher.success { nil }
          matcher.failure { |value| value }
        end
      end

      def prior_target_state
        @use_case_target.attribute_hash
      end

      def succeeded?
        @use_case_result.success?
      end

      def target_identifier
        @use_case_target.identifier
      end

      def use_case_class_name
        @use_case_class.name
      end

      def user_identifier
        @use_case_parameters.actor.user_identifier
      end
    end
  end
end
