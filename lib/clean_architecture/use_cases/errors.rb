# frozen_string_literal: true

require 'active_model'
require 'active_support/core_ext/string/inflections'

module CleanArchitecture
  module UseCases
    # Acts as a facade in front of ActiveModel::Errors implementing the bare minimum of the API
    # It also implements the same interface as a FailureDetails so as to be interchangeable if
    # passed back to code expecting a FailureDetails
    class Errors
      extend Forwardable
      include ActiveModel::Translation

      DEFAULT_FAILURE_DETAILS_TYPE = 'error'

      def initialize(base, type = DEFAULT_FAILURE_DETAILS_TYPE)
        @active_model_errors = ActiveModel::Errors.new(base)
        @type = type
      end

      attr_reader :type

      def message
        full_messages.join(', ')
      end

      def other_properties
        {}
      end

      def_delegators :@active_model_errors,
                     :count,
                     :each,
                     :size,
                     :clear,
                     :blank?,
                     :empty?,
                     :add

      ATTRIBUTE_NAME_HUMANIZE_OPTIONS = { capitalize: true, keep_id_suffix: false }
      BASE_NAME = :base

      def full_messages
        @active_model_errors.messages.map do |attribute, messages|
          attribute_name = if attribute == BASE_NAME
            nil
          else
            ActiveSupport::Inflector.humanize(attribute, ATTRIBUTE_NAME_HUMANIZE_OPTIONS)
          end
          messages.map { |message| [attribute_name, message].compact.join(' ') }
        end.flatten
      end
    end
  end
end
