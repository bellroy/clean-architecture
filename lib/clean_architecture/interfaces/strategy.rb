# frozen_string_literal: true

module CleanArchitecture
  module Interfaces
    module Strategy
      extend Duckface::ActsAsInterface

      def parameters
        raise NotImplementedError
      end

      def result
        raise NotImplementedError
      end
    end
  end
end
