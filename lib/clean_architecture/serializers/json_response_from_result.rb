# typed: strict
# frozen_string_literal: true

require 'clean_architecture/entities/failure_details'
require 'clean_architecture/matchers/use_case_result'
require 'clean_architecture/queries/http_failure_code'
require 'clean_architecture/queries/http_success_code'
require 'sorbet-runtime'

module CleanArchitecture
  module Serializers
    class JsonResponseFromResult
      extend T::Sig

      sig { params(result: Dry::Monads::Result[T.any(T::Array[Object], String, Entities::FailureDetails), T.untyped], http_method: String, success_payload_proc: T.proc.params(success_value: T.untyped).returns(T::Hash[T.untyped, T.untyped])).void }
      def initialize(result, http_method, success_payload_proc)
        @result = result
        @http_method = http_method
        @success_payload_proc = success_payload_proc
      end

      sig { returns(T::Hash[Symbol, T.untyped]) }
      def to_h
        {
          status: http_status_code,
          json: json
        }
      end

      private

      sig { returns(Symbol) }
      def http_status_code
        Matchers::UseCaseResult.call(@result) do |matcher|
          matcher.success { Queries::HttpSuccessCode.new(@http_method).to_sym }
          matcher.failure do |failure_value|
            Queries::HttpFailureCode.new(failure_value.type).to_sym
          end
        end
      end

      sig { returns(T::Hash[Symbol, T.untyped]) }
      def json
        Matchers::UseCaseResult.call(@result) do |matcher|
          matcher.success { |value| { data: @success_payload_proc.call(value) } }
          matcher.failure do |failure_details|
            { errors: [failure_details.message] }
          end
        end
      end
    end
  end
end
