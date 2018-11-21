# frozen_string_literal: true

require 'duckface'
require 'clean_architecture/interfaces/success_payload'
require 'clean_architecture/serializers/success_payload'

module CleanArchitecture
  module Serializers
    class SuccessCollectionPayload
      implements_interface CleanArchitecture::Interfaces::SuccessPayload

      def initialize(collection, use_case_target_class)
        @collection = collection
        @use_case_target_class = use_case_target_class
      end

      def data
        @collection.map do |object|
          SuccessPayload.new(@use_case_target_class.new(object)).data
        end
      end

      def version
        '1.0'
      end
    end
  end
end
