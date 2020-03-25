# typed: false
# frozen_string_literal: true

require 'duckface'

module CleanArchitecture
  module Interfaces
    module BaseParameters
      extend Duckface::ActsAsInterface

      def extra_parameters_hash
        raise NotImplementedError
      end

      def gateway
        raise NotImplementedError
      end

      def settings
        raise NotImplementedError
      end
    end
  end
end
