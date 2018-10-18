# frozen_string_literal: true

require 'dry/matcher/result_matcher'
require 'clean_architecture/entities/failure_details'
require 'clean_architecture/queries/http_success_code'
require 'clean_architecture/queries/http_failure_code'

module CleanArchitecture
  module Serializers
    class HtmlResponseFromResult
      def initialize(result, http_method)
        @result = result
        @http_method = http_method
      end

      def to_h
        Dry::Matcher::ResultMatcher.call(@result) do |matcher|
          matcher.success { |data| success_html_response(data) }
          matcher.failure { |failure_value| failure_html_response(failure_value) }
        end
      end

      private

      def success_html_response(data)
        { status: Queries::HttpSuccessCode.new(@http_method).to_sym, data: data }
      end

      def failure_html_response(failure_value)
        if failure_value.is_a?(Entities::FailureDetails)
          status = Queries::HttpFailureCode.new(failure_value.type).to_sym
          { status: status, error: failure_value.message }
        elsif result_is_authorization_failure?
          { status: :unauthorized, error: failure_value }
        else
          { status: :expectation_failed, error: failure_value }
        end
      end

      def result_is_authorization_failure?
        msg = @result.failure
        msg.is_a?(String) && !msg.index('Unauthorized: ').nil?
      end
    end
  end
end
