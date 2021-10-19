# typed: false
# frozen_string_literal: true

require 'sorbet-runtime'

module CleanArchitecture
  module Builders
    describe AbstractActiveRecordEntityBuilder do
      class ExampleModel < ActiveRecord::Base
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

      class ExampleInterestModel < ActiveRecord::Base
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

      class ExampleInterest < T::Struct
        include T::Struct::ActsAsComparable

        const :label, String
      end

      class ExampleEntity < T::Struct
        extend T::Sig

        include T::Struct::ActsAsComparable

        const :forename, String
        const :surname, String
        const :years_on_planet_earth, Integer
        const :main_interest, ExampleInterest
        const :not_interested_in, T.nilable(ExampleInterest)
        const :other_interests, T::Array[ExampleInterest]
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

        let(:builder) { ExampleBuilder.new(ar_model_instance) }

        before do
          allow(ExampleModel).to receive(:_has_attribute?).with('type').and_return(false)
          allow(ExampleModel).to receive(:_default_attributes).and_return({})
          allow(ExampleModel).to receive(:primary_key).and_return(:id)
          allow(ExampleModel).to receive(:attribute_names).and_return(
            %w[forename surname age main_interest not_interested_in other_interests]
          )

          allow(ExampleInterestModel).to receive(:_has_attribute?).with('type').and_return(false)
          allow(ExampleInterestModel).to receive(:_default_attributes).and_return({})
          allow(ExampleInterestModel).to receive(:primary_key).and_return(:id)
          allow(ExampleInterestModel).to receive(:attribute_names).and_return(%w[label])
        end

        specify do
          expect(built_entity).to eq ExampleEntity.new(
            forename: 'Samuel',
            surname: 'Giles',
            years_on_planet_earth: 26,
            main_interest: ExampleInterest.new(label: 'Music'),
            not_interested_in: nil,
            other_interests: [
              ExampleInterest.new(label: 'Travel'),
              ExampleInterest.new(label: 'Cycling')
            ]
          )
        end
      end
    end
  end
end
