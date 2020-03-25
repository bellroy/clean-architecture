# typed: true
# frozen_string_literal: true

require 'clean_architecture/interfaces/base_parameters'

module CleanArchitecture
  module Entities
    class UntargetedParameters
      attr_reader :actor, :extra_parameters_hash, :gateway, :settings

      implements_interface Interfaces::BaseParameters

      def initialize(actor, extra_parameters_hash, gateway, settings)
        @actor = actor
        @extra_parameters_hash = extra_parameters_hash
        @gateway = gateway
        @settings = settings
      end
    end
  end
end
