# frozen_string_literal: true

require 'duckface'

module CleanArchitecture
  module Serializers
    class SuccessPayload
      implements_interface CleanArchitecture::Interfaces::SuccessPayload

      attr_reader :version

      def initialize(use_case_target, version)
        @use_case_target = use_case_target
        @version = version
      end

      def data_hash
        {
          type: @use_case_target.type_name,
          id: @use_case_target.identifier,
          attributes: @use_case_target.attribute_hash
        }.compact
      end
    end
  end
end
