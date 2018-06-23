# frozen_string_literal: true

require 'dry/matcher/result_matcher'

module CleanArchitecture
  module Serializers
    class HtmlResponseFromResult
      def initialize(result, http_method)
        @result = result
        @http_method = http_method
      end

      def to_h
        Dry::Matcher::ResultMatcher.call(@result) do |matcher|
          matcher.success do |data|
            { status: Queries::HttpSuccessCode.new(@http_method).to_sym, data: data }
          end
          matcher.failure { |error_message| { status: :error, error: error_message } }
        end
      end
    end
  end
end
