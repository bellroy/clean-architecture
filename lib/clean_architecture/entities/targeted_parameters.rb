# frozen_string_literal: true

module CleanArchitecture
  module Entities
    class TargetedParameters
      attr_reader :actor, :extra_parameters_hash, :persistence, :target, :settings

      implements_interface Interfaces::TargetedParameters
      implements_interface Interfaces::AuthorizationParameters

      def initialize(actor, target, extra_parameters_hash, persistence, settings)
        @actor = actor
        @target = target
        @extra_parameters_hash = extra_parameters_hash
        @persistence = persistence
        @settings = settings
      end
    end
  end
end
