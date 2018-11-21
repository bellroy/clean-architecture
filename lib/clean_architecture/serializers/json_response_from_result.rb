# frozen_string_literal: true

require 'clean_architecture/entities/failure_details'
require 'clean_architecture/matchers/use_case_result'
require 'clean_architecture/queries/http_failure_code'
require 'clean_architecture/queries/http_success_code'

module CleanArchitecture
  module Serializers
    class JsonResponseFromResult
      def initialize(result, http_method, success_payload)
        @result = result
        @http_method = http_method
        @success_payload = success_payload
      end

      def to_h
        {
          status: http_status_code,
          json: json
        }
      end

      private

      def http_status_code
        Matchers::UseCaseResult.call(@result) do |matcher|
          matcher.success { Queries::HttpSuccessCode.new(@http_method).to_sym }
          matcher.failure do |failure_value|
            Queries::HttpFailureCode.new(failure_value.type).to_sym
          end
        end
      end

      def json
        Matchers::UseCaseResult.call(@result) do |matcher|
          matcher.success { success_payload }
          matcher.failure do |failure_details|
            { jsonapi: json_api_version_hash, errors: [failure_details.message] }
          end
        end
      end

      def success_payload
        {
          jsonapi: json_api_version_hash,
          data: @success_payload.data
        }
      end

      def json_api_version_hash
        { version: @success_payload.version }
      end
    end
  end
end
