# typed: false
# frozen_string_literal: true

require 'clean_architecture/types'
require 'dry/struct'

module CleanArchitecture
  module Entities
    class FailureDetails < Dry::Struct
      FailureTypes = Types::Strict::String.enum(
        'error',
        'expectation_failed',
        'not_found',
        'unauthorized',
        'unprocessable_entity'
      )

      attribute :type, FailureTypes
      attribute :message, Types::Strict::String
      attribute :other_properties, Types::Strict::Hash.default({}.freeze)

      def self.from_array(array)
        new(message: array.map(&:to_s).join(', '), other_properties: {}, type: 'error')
      end

      def self.from_string(string)
        new(message: string, other_properties: {}, type: 'error')
      end
    end
  end
end
