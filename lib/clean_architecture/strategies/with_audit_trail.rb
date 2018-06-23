# frozen_string_literal: true

require 'duckface'

module CleanArchitecture
  module Strategies
    class WithAuditTrail
      implements_interface Interfaces::Strategy
      extend Forwardable

      def initialize(use_case_class, sub_strategy, use_case_target)
        @use_case_class = use_case_class
        @sub_strategy = sub_strategy
        @use_case_target = use_case_target
      end

      def result
        @result ||= begin
          strategy_result = @sub_strategy.result
          entry = new_use_case_history_entry(strategy_result)
          parameters.persistence.create_use_case_history_entry(entry)
          strategy_result
        end
      end

      def_delegator :@sub_strategy, :parameters

      private

      def new_use_case_history_entry(sub_strategy_result)
        Entities::UseCaseHistoryEntry.new(
          @use_case_class,
          @sub_strategy.parameters,
          sub_strategy_result,
          @use_case_target
        )
      end
    end
  end
end
