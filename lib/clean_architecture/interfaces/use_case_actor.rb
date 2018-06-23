# frozen_string_literal: true

require 'duckface'

module CleanArchitecture
  module Interfaces
    module UseCaseActor
      extend Duckface::ActsAsInterface

      def authorized?(_action, _target)
        raise NotImplementedError
      end

      def user_identifier
        raise NotImplementedError
      end
    end
  end
end
