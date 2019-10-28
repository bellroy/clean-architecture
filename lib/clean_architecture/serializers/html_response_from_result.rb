# typed: true
# frozen_string_literal: true

require 'clean_architecture/entities/failure_details'
require 'clean_architecture/matchers/use_case_result'
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
        Matchers::UseCaseResult.call(@result) do |matcher|
          matcher.success { |data| success_html_response(data) }
          matcher.failure { |failure_details| failure_html_response(failure_details) }
        end
      end

      private

      def success_html_response(data)
        { status: Queries::HttpSuccessCode.new(@http_method).to_sym, data: data }
      end

      def failure_html_response(failure_details)
        status = Queries::HttpFailureCode.new(failure_details.type).to_sym
        { status: status, error: failure_details.message }
      end
    end
  end
end
