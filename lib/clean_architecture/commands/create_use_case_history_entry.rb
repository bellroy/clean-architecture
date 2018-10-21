# frozen_string_literal: true

require 'clean_architecture/entities/use_case_history_entry'
require 'duckface'

module CleanArchitecture
  module Commands
    class CreateUseCaseHistoryEntry
      extend Forwardable

      def initialize(use_case_target)
        @use_case_target = use_case_target
      end

      def result
        @result ||= begin
          entry = Entities::UseCaseHistoryEntry.new(@use_case_target)
          parameters.persistence.create_use_case_history_entry(entry)
        end
      end
    end
  end
end
