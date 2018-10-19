# frozen_string_literal: true

module CleanArchitecture
  module Queries
    class HttpFailureCode
      def initialize(failure_details_type)
        @failure_details_type = failure_details_type
      end

      def to_sym
        code = FAILURE_DETAILS_TYPE_TO_STATUS_CODE[@failure_details_type.to_s.downcase]
        if code.nil?
          raise NotImplementedError,
                "cannot determine failure code for failure details type #{@failure_details_type}"
        end

        code
      end

      private

      FAILURE_DETAILS_TYPE_TO_STATUS_CODE = {
        'error' => :internal_server_error,
        'expectation_failed' => :expectation_failed,
        'not_found' => :not_found,
        'unauthorized' => :unauthorized
      }.freeze
    end
  end
end
