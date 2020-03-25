# typed: true
# frozen_string_literal: true

require 'clean_architecture/interfaces/targeted_parameters'
require 'clean_architecture/interfaces/authorization_parameters'

module CleanArchitecture
  module Entities
    class TargetedParameters
      attr_reader :actor, :extra_parameters_hash, :gateway, :target, :settings

      implements_interface Interfaces::TargetedParameters
      implements_interface Interfaces::AuthorizationParameters

      def initialize(actor, target, extra_parameters_hash, gateway, settings)
        @actor = actor
        @target = target
        @extra_parameters_hash = extra_parameters_hash
        @gateway = gateway
        @settings = settings
      end
    end
  end
end
