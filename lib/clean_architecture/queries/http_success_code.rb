# typed: strict
# frozen_string_literal: true

module CleanArchitecture
  module Queries
    class HttpSuccessCode
      extend T::Sig

      sig { params(http_method: String).void }
      def initialize(http_method)
        @http_method = http_method
      end

      sig { returns(Symbol) }
      def to_sym
        code = HTTP_METHOD_TO_SUCCESS_CODE[@http_method.to_s.upcase]
        if code.nil?
          raise NotImplementedError, "cannot determine success code for HTTP method #{@http_method}"
        end

        code
      end

      private

      HTTP_METHOD_TO_SUCCESS_CODE = T.let(
        {
          'GET' => :ok,
          'POST' => :created,
          'PUT' => :accepted,
          'DELETE' => :ok
        }.freeze,
        T::Hash[String, Symbol]
      )
    end
  end
end
