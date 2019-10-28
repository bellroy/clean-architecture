# typed: true
# frozen_string_literal: true

require 'clean_architecture/interfaces/base_parameters'

module CleanArchitecture
  module Entities
    class UntargetedParameters
      attr_reader :actor, :extra_parameters_hash, :persistence, :settings

      implements_interface Interfaces::BaseParameters

      def initialize(actor, extra_parameters_hash, persistence, settings)
        @actor = actor
        @extra_parameters_hash = extra_parameters_hash
        @persistence = persistence
        @settings = settings
      end
    end
  end
end
