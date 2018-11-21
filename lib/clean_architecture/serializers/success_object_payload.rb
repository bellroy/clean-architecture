# frozen_string_literal: true

require 'duckface'
require 'clean_architecture/interfaces/success_object_payload'

module CleanArchitecture
  module Serializers
    class SuccessObjectPayload
      implements_interface CleanArchitecture::Interfaces::SuccessObjectPayload

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
