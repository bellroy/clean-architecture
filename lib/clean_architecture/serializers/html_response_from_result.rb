# typed: strict
# frozen_string_literal: true

require 'clean_architecture/entities/failure_details'
require 'clean_architecture/matchers/use_case_result'
require 'clean_architecture/queries/http_success_code'
require 'clean_architecture/queries/http_failure_code'

module CleanArchitecture
  module Serializers
    class HtmlResponseFromResult
      extend T::Sig

      sig { params(result: Dry::Monads::Result[Entities::FailureDetails, T.untyped], http_method: String).void }
      def initialize(result, http_method)
        @result = result
        @http_method = http_method
      end

      sig { returns(T::Hash[Symbol, Object]) }
      def to_h
        Matchers::UseCaseResult.call(@result) do |matcher|
          matcher.success { |data| success_html_response(data) }
          matcher.failure { |failure_details| failure_html_response(failure_details) }
        end
      end

      private

      sig { params(data: Object).returns(T::Hash[Symbol, Object]) }
      def success_html_response(data)
        { status: Queries::HttpSuccessCode.new(@http_method).to_sym, data: data }
      end

      sig { params(failure_details: Entities::FailureDetails).returns(T::Hash[Symbol, Object]) }
      def failure_html_response(failure_details)
        status = Queries::HttpFailureCode.new(failure_details.type).to_sym
        { status: status, error: failure_details.message }
      end
    end
  end
end
