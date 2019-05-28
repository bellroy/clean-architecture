# frozen_string_literal: true

require 'clean_architecture/builders/abstract_active_record_entity_builder'
require 'clean_architecture/types'
require 'dry-struct'

module CleanArchitecture
  module Builders
    describe AbstractActiveRecordEntityBuilder do
      class ExampleModel
        def age
          26
        end

        def main_interest
          ExampleInterestModel.new('Music')
        end

        def not_interested_in
          nil
        end

        def other_interests
          [
            ExampleInterestModel.new('Travel'),
            ExampleInterestModel.new('Cycling')
          ]
        end

        def attributes
          {
            'forename' => 'Samuel',
            'surname' => 'Giles',
            'age' => age,
            'main_interest' => main_interest,
            'not_interested_in' => not_interested_in,
            'other_interests' => other_interests
          }
        end
      end

      class ExampleInterestModel
        def initialize(label)
          @label = label
        end

        attr_reader :label

        def attributes
          {
            'label' => label
          }
        end
      end

      class ExampleInterest < Dry::Struct
        attribute :label, Types::Strict::String

        def initialize(attributes)
          @attributes = attributes
        end
      end

      class ExampleEntity < Dry::Struct
        attribute :forename, Types::Strict::String
        attribute :surname, Types::Strict::String
        attribute :years_on_planet_earth, Types::Strict::Integer
        attribute :main_interest, Types.Instance(ExampleInterest)
        attribute :not_interested_in, Types.Instance(ExampleInterest).optional
        attribute :other_interests, Types.Array(Types.Instance(ExampleInterest))

        def initialize(attributes)
          @attributes = attributes
        end
      end

      class ExampleInterestBuilder < AbstractActiveRecordEntityBuilder
        acts_as_builder_for_entity ExampleInterest
      end

      class ExampleBuilder < AbstractActiveRecordEntityBuilder
        acts_as_builder_for_entity ExampleEntity

        belongs_to :main_interest, use: ExampleInterestBuilder
        belongs_to :not_interested_in, use: ExampleInterestBuilder
        has_many :other_interests, use: ExampleInterestBuilder

        def attributes_for_entity
          {
            years_on_planet_earth: ar_model_instance.age
          }
        end
      end

      let(:builder) { ExampleBuilder.new(ar_model_instance) }
      let(:ar_model_instance) { ExampleModel.new }

      describe '#build' do
        subject(:built_entity) { builder.build }

        specify do
          expect(built_entity).to be_an_instance_of(ExampleEntity)
          expect(built_entity.forename).to eq 'Samuel'
          expect(built_entity.surname).to eq 'Giles'
          expect(built_entity.years_on_planet_earth).to eq 26
          expect(built_entity.main_interest).to eq ExampleInterest.new(label: 'Music')
          expect(built_entity.not_interested_in).to be nil
          expect(built_entity.other_interests).to eq [
            ExampleInterest.new(label: 'Travel'),
            ExampleInterest.new(label: 'Cycling')
          ]
        end
      end
    end
  end
end
