# frozen_string_literal: true

require 'clean_architecture/interfaces/base_parameters'
require 'duckface'

module CleanArchitecture
  module Interfaces
    module TargetedParameters
      extend Duckface::ActsAsInterface

      include BaseParameters

      def target
        raise NotImplementedError
      end
    end
  end
end
