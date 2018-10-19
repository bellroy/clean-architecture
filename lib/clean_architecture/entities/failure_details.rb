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
        'unauthorized'
      )

      attribute :type, FailureTypes
      attribute :message, Types::Strict::String
      attribute :other_properties, Types::Strict::Hash
    end
  end
end
