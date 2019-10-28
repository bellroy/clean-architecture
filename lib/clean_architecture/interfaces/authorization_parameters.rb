# typed: false
# frozen_string_literal: true

require 'clean_architecture/interfaces/base_parameters'
require 'duckface'

module CleanArchitecture
  module Interfaces
    module AuthorizationParameters
      extend Duckface::ActsAsInterface

      include BaseParameters

      def actor
        raise NotImplementedError
      end
    end
  end
end
