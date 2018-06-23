# frozen_string_literal: true

require 'duckface'

module CleanArchitecture
  module Interfaces
    module UseCaseHistoryEntry
      extend Duckface::ActsAsInterface

      def extra_parameters_hash
        raise NotImplementedError
      end

      def failure_messages
        raise NotImplementedError
      end

      def prior_target_state
        raise NotImplementedError
      end

      def succeeded?
        raise NotImplementedError
      end

      def target_identifier
        raise NotImplementedError
      end

      def use_case_class_name
        raise NotImplementedError
      end

      def user_identifier
        raise NotImplementedError
      end
    end
  end
end
