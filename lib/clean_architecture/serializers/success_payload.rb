# typed: true
# frozen_string_literal: true

require 'duckface'
require 'clean_architecture/interfaces/success_payload'

module CleanArchitecture
  module Serializers
    class SuccessPayload
      implements_interface CleanArchitecture::Interfaces::SuccessPayload

      def initialize(use_case_target)
        @use_case_target = use_case_target
      end

      def data
        {
          type: @use_case_target.type_name,
          id: @use_case_target.identifier,
          attributes: @use_case_target.attribute_hash
        }.compact
      end

      def version
        '1.0'
      end
    end
  end
end
