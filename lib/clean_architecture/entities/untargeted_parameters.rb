# frozen_string_literal: true

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
