# frozen_string_literal: true

require 'duckface'

module CleanArchitecture
  module Interfaces
    module Jsonable
      extend Duckface::ActsAsInterface

      def to_json
        raise NotImplementedError
      end
    end
  end
end
