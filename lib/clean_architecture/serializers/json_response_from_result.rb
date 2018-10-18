# frozen_string_literal: true

require 'dry-monads'
require 'dry/matcher/result_matcher'
require 'clean_architecture/entities/failure_details'
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
        Dry::Matcher::ResultMatcher.call(@result) do |matcher|
          matcher.success { Queries::HttpSuccessCode.new(@http_method).to_sym }
          matcher.failure do |failure_value|
            if failure_value.is_a?(Entities::FailureDetails)
              Queries::HttpFailureCode.new(failure_value.type).to_sym
            elsif result_is_authorization_failure?
              :unauthorized
            else
              :expectation_failed
            end
          end
        end
      end

      def json
        Dry::Matcher::ResultMatcher.call(@result) do |matcher|
          matcher.success { success_payload }
          matcher.failure { |failure_value| error_payload(failure_value) }
        end
      end

      def success_payload
        {
          jsonapi: json_api_version_hash,
          data: @success_payload.data_hash
        }
      end

      def error_payload(failure_value)
        msg = failure_value.is_a?(Entities::FailureDetails) ? failure_value.message : failure_value
        {
          jsonapi: json_api_version_hash,
          errors: [msg]
        }
      end

      def json_api_version_hash
        { version: @success_payload.version }
      end

      def result_is_authorization_failure?
        msg = @result.failure
        msg.is_a?(String) && !msg.index('Unauthorized: ').nil?
      end
    end
  end
end
