# typed: strict
# frozen_string_literal: true

require 'active_record'

module CleanArchitecture
  module Builders
    # Helps to take an instance of an AR model and wrap it up in the given Entity
    # Any columns from the AR model that do not directly map to an attribute on the Entity
    # can be specified by overriding #attributes_for_entity.
    class AbstractActiveRecordEntityBuilder
      extend T::Sig

      sig { params(entity_class: T.class_of(T::Struct)).void }
      def self.acts_as_builder_for_entity(entity_class)
        @has_many_builders = []
        @belongs_to_builders = []

        define_singleton_method :has_many_builders do
          @has_many_builders
        end

        define_singleton_method :belongs_to_builders do
          @belongs_to_builders
        end

        define_method :entity_class do
          entity_class
        end

        private :entity_class
      end

      sig { params(relation_name: Symbol, use: Class).void }
      def self.has_many(relation_name, use:)
        @has_many_builders = T.let(@has_many_builders, T.nilable(T::Array[Object]))
        T.must(@has_many_builders) << [relation_name, use]
      end

      sig { params(relation_name: Symbol, use: Class).void }
      def self.belongs_to(relation_name, use:)
        @belongs_to_builders = T.let(@belongs_to_builders, T.nilable(T::Array[Object]))
        T.must(@belongs_to_builders) << [relation_name, use]
      end

      sig { params(ar_model_instance: ActiveRecord::Base).void }
      def initialize(ar_model_instance)
        @ar_model_instance = ar_model_instance
      end

      sig { returns(T::Struct) }
      def build
        specified_entity_class.new(all_attributes_for_entity)
      end

      sig { returns(T.class_of(T::Struct)) }
      def specified_entity_class
        send(:entity_class)
      end

      private

      sig { returns(ActiveRecord::Base) }
      attr_reader :ar_model_instance

      sig { returns(T::Array[Symbol]) }
      def entity_attribute_names
        @entity_attributes = T.let(@entity_attributes, T.nilable(T::Array[Symbol]))
        @entity_attributes ||= begin
          if specified_entity_class.respond_to?(:decorator) # T::Struct
            schema_keys = specified_entity_class.decorator.props.keys
          else
            raise 'Cannot determine schema format'
          end
          first_key = schema_keys.first
          if first_key.is_a?(Symbol)
            schema_keys
          elsif first_key.respond_to?(:name)
            schema_keys.map(&:name)
          else
            raise 'Cannot determine schema format'
          end
        end
      end

      sig { returns(T::Hash[Symbol, Object]) }
      def ar_model_instance_attributes
        @ar_model_instance_attributes = T.let(
          @ar_model_instance_attributes,
          T.nilable(T::Hash[Symbol, Object])
        )
        @ar_model_instance_attributes ||= @ar_model_instance.attributes
      end

      sig { returns(T::Hash[Symbol, Object]) }
      def symbolized_ar_model_instance_attributes
        @symbolized_ar_model_instance_attributes = T.let(
          @symbolized_ar_model_instance_attributes,
          T.nilable(T::Hash[Symbol, Object])
        )
        @symbolized_ar_model_instance_attributes ||= Hash[
          ar_model_instance_attributes.map{|(key, value)| [key.to_sym, value]}
        ]
      end

      sig { returns(T::Hash[Symbol, Object]) }
      def ar_attributes_for_entity
        T.unsafe(symbolized_ar_model_instance_attributes).slice(*entity_attribute_names)
      end

      sig { returns(T::Hash[Symbol, Object]) }
      def attributes_for_belongs_to_relations
        T.unsafe(self.class).belongs_to_builders.map do |belongs_to_builder_config|
          relation_name, builder_class = belongs_to_builder_config
          relation = @ar_model_instance.public_send(relation_name)

          [
            relation_name,
            relation ? builder_class.new(relation).build : nil
          ]
        end.to_h
      end

      sig { returns(T::Hash[Symbol, Object]) }
      def attributes_for_has_many_relations
        T.unsafe(self.class).has_many_builders.map do |has_many_builder_config|
          relation_name, builder_class = has_many_builder_config
          relations = @ar_model_instance.public_send(relation_name)
          built_relations = relations.map do |relation|
            builder_class.new(relation).build
          end

          [
            relation_name,
            built_relations
          ]
        end.to_h
      end

      sig { returns(T::Hash[Symbol, Object]) }
      def attributes_for_entity
        {}
      end

      sig { returns(T::Hash[Symbol, Object]) }
      def all_attributes_for_entity
        ar_attributes_for_entity
          .merge(attributes_for_belongs_to_relations)
          .merge(attributes_for_has_many_relations)
          .merge(attributes_for_entity)
      end
    end
  end
end
