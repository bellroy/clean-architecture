# frozen_string_literal: true

require 'clean_architecture/builders/abstract_active_record_entity_builder'
require 'clean_architecture/types'
require 'dry-struct'

module CleanArchitecture
  module Builders
    describe AbstractActiveRecordEntityBuilder do
      class ExampleModel
        def age
          25
        end

        def attributes
          {
            'forename' => 'Samuel',
            'surname' => 'Giles',
            'age' => 25
          }
        end
      end

      class ExampleEntity < Dry::Struct
        attribute :forename, Types::Strict::String
        attribute :surname, Types::Strict::String
        attribute :years_on_planet_earth, Types::Strict::Integer

        def initialize(attributes)
          @attributes = attributes
        end
      end

      class ExampleBuilder < AbstractActiveRecordEntityBuilder
        acts_as_builder_for_entity ExampleEntity

        def attributes_for_entity
          {
            years_on_planet_earth: ar_model_instance.age
          }
        end
      end

      let(:builder) { ExampleBuilder.new(ar_model_instance) }
      let(:ar_model_instance) { ExampleModel.new }

      describe '#build' do
        subject(:build) { builder.build }

        let(:example_entity) { instance_double(ExampleEntity) }

        before do
          expect(ExampleEntity)
            .to receive(:new)
            .with(
              forename: 'Samuel',
              surname: 'Giles',
              years_on_planet_earth: 25
            )
            .and_return(example_entity)
        end

        it { is_expected.to eq example_entity }
      end
    end
  end
end
