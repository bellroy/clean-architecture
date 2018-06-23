# frozen_string_literal: true

require 'duckface'

module CleanArchitecture
  module Interfaces
    module Persistence
      extend Duckface::ActsAsInterface

      def create_use_case_history_entry(_use_case_history_entry)
        raise NotImplementedError
      end
    end
  end
end
