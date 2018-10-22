# frozen_string_literal: true

require 'duckface'

module CleanArchitecture
  module Interfaces
    module UseCase
      extend Duckface::ActsAsInterface

      def initialize(_parameters)
        raise NotImplementedError
      end

      def result
        raise NotImplementedError
      end
    end
  end
end
