# frozen_string_literal: true

module CleanArchitecture
  module Queries
    class HttpSuccessCode
      def initialize(http_method)
        @http_method = http_method
      end

      def to_sym
        code = HTTP_METHOD_TO_SUCCESS_CODE[@http_method.to_s.upcase]
        if code.nil?
          raise NotImplementedError, "cannot determine success code for HTTP method #{@http_method}"
        end

        code
      end

      private

      HTTP_METHOD_TO_SUCCESS_CODE = {
        'GET' => :ok,
        'POST' => :created,
        'PUT' => :accepted,
        'DELETE' => :ok
      }.freeze
    end
  end
end
