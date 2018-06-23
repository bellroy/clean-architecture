# frozen_string_literal: true

require 'duckface'

module CleanArchitecture
  module Interfaces
    module UseCaseTarget
      extend Duckface::ActsAsInterface

      def attribute_hash
        raise NotImplementedError
      end

      def identifier
        raise NotImplementedError
      end

      def type_name
        raise NotImplementedError
      end
    end
  end
end
