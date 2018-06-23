# frozen_string_literal: true

require 'dry-monads'
require 'dry/matcher/result_matcher'

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
          matcher.failure do
            if result_is_authorization_failure?
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
          matcher.failure { |failure_message| error_payload(failure_message) }
        end
      end

      def success_payload
        {
          jsonapi: json_api_version_hash,
          data: @success_payload.data_hash
        }
      end

      def error_payload(failure_message)
        {
          jsonapi: json_api_version_hash,
          errors: [failure_message]
        }
      end

      def json_api_version_hash
        { version: @success_payload.version }
      end

      def result_is_authorization_failure?
        !@result.failure.index('Unauthorized: ').nil?
      end
    end
  end
end
