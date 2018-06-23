# frozen_string_literal: true

require 'duckface'

module CleanArchitecture
  module Interfaces
    module AuthorizationCheck
      extend Duckface::ActsAsInterface

      def authorized?
        raise NotImplementedError
      end
    end
  end
end
