# frozen_string_literal: true

module CleanArchitecture
  module Builders
    # Helps to take an instance of an AR model and wrap it up in the given Entity
    # Any columns from the AR model that do not directly map to an attribute on the Entity
    # can be specified by overriding #attributes_for_entity.
    class AbstractActiveRecordEntityBuilder
      # @param [Class] A Dry::Struct based entity that this builder will construct instances of
      def self.acts_as_builder_for_entity(entity_class)
        define_method :entity_class do
          entity_class
        end

        private :entity_class
      end

      # @param [ActiveRecord::Base] An ActiveRecord model to map to the entity
      def initialize(ar_model_instance)
        @ar_model_instance = ar_model_instance
      end

      def build
        entity_class.new(all_attributes_for_entity)
      end

      private

      attr_reader :ar_model_instance

      def entity_attribute_names
        @entity_attributes ||= entity_class.schema.keys
      end

      def ar_attributes_for_entity
        attributes_for_entity = @ar_model_instance.attributes
        symbolized_attributes_for_entity = Hash[attributes_for_entity.map{|(key, value)| [key.to_sym, value]}]
        symbolized_attributes_for_entity.slice(*entity_attribute_names)
      end

      def attributes_for_entity
        {}
      end

      def all_attributes_for_entity
        ar_attributes_for_entity.merge(attributes_for_entity)
      end
    end
  end
end
