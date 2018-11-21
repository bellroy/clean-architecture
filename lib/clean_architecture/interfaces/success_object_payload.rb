# frozen_string_literal: true

require 'duckface'

module CleanArchitecture
  module Interfaces
    module SuccessObjectPayload
      extend Duckface::ActsAsInterface

      def data_hash
        raise NotImplementedError
      end

      def version
        raise NotImplementedError
      end
    end
  end
end
