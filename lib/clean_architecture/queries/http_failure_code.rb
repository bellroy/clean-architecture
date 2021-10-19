# typed: strict
# frozen_string_literal: true

module CleanArchitecture
  module Queries
    class HttpFailureCode
      extend T::Sig

      sig { params(failure_type: Entities::FailureType).void }
      def initialize(failure_type)
        @failure_type = failure_type
      end

      sig { returns(Symbol) }
      def to_sym
        @failure_type.serialize.to_sym
      end
    end
  end
end
