# frozen_string_literal: true

require 'clean_architecture/adapters/attribute_hash_base'

module CleanArchitecture
  module Adapters
    describe AttributeHashBase do
      # Example class to test the nested adapter functionality
      class AnotherExampleAdapter < AttributeHashBase
        def initialize(_hash, *_args); end
      end

      # Example class to test provided methods
      class ExampleAdapter < AttributeHashBase
        def boolean
          boolean_value(:boolean)
        end

        def complex_object
          complex_object_value(:complex_object, AnotherExampleAdapter)
        end

        def complex_object_list
          complex_object_list_value(:complex_object_list, AnotherExampleAdapter)
        end

        def complex_object_list_value_with_arguments
          complex_object_list_value(:complex_object_list, AnotherExampleAdapter, self)
        end

        def currency
          currency_value(:currency)
        end

        def date_time
          date_time_value(:date_time)
        end

        def float
          float_value(:float)
        end

        def int
          int_value(:int)
        end

        def regex_from_string
          regex_value(:regex_string)
        end

        def regex
          regex_value(:regex)
        end

        def symbol
          symbol_value(:symbol)
        end

        def symbol_string
          symbol_value(:symbol_string)
        end

        def ensured_string
          ensured_value(default: 'Hello') { string_value(:ensured) }
        end
      end

      let(:example_instance) { ExampleAdapter.new(attribute_hash) }
      let(:attribute_hash) do
        {
          boolean: true,
          complex_object: complex_object_value,
          complex_object_list: complex_object_list,
          currency: '34.23',
          date_time: '2018-06-12T11:41:12.000+0000',
          float: '2434242.221',
          int: '23',
          regex_string: '^\d+-\d+-\d+$',
          regex: example_regex,
          symbol: :hello_world,
          symbol_string: 'hello_world'
        }
      end
      let(:example_regex) { /^\d+-\d+-\d+$/ }
      let(:complex_object_value) do
        {
          hello: 'world'
        }
      end
      let(:complex_object_list) { [complex_object_value] }
      let(:example_time) { Time.at(1_528_803_672).utc }

      describe '#boolean_value' do
        subject(:value) { example_instance.boolean }

        it { is_expected.to be true }
      end

      describe '#complex_object' do
        subject(:value) { example_instance.complex_object }

        let(:example_object_adapter) { instance_double(AnotherExampleAdapter) }

        before do
          allow(AnotherExampleAdapter)
            .to receive(:new)
            .with(complex_object_value)
            .and_return(example_object_adapter)
        end

        it { is_expected.to eq example_object_adapter }
      end

      describe '#complex_object_list' do
        subject(:value) { example_instance.complex_object_list }

        let(:example_object_adapter) { instance_double(AnotherExampleAdapter) }

        before do
          allow(AnotherExampleAdapter)
            .to receive(:new)
            .with(complex_object_value)
            .and_return(example_object_adapter)
        end

        context 'when the complex object list is an array' do
          it { is_expected.to eq [example_object_adapter] }
        end

        context 'when the complex object list is not an array' do
          let(:complex_object_list) { 'Whats up doc' }

          specify do
            expect { value }
              .to raise_error(
                described_class::EmptyOrIncorrectAttributeTypeError,
                'value at key complex_object_list is not an array!'
              )
          end
        end

        context 'with additional arguments' do
          subject(:value) { example_instance.complex_object_list_value_with_arguments }

          let(:example_object_adapter_with_argument) { instance_double(AnotherExampleAdapter) }

          before do
            allow(AnotherExampleAdapter)
              .to receive(:new)
              .with(complex_object_value, example_instance)
              .and_return(example_object_adapter_with_argument)
          end

          it { is_expected.to eq [example_object_adapter_with_argument] }
        end
      end

      describe '#currency' do
        subject(:value) { example_instance.currency }

        it { is_expected.to eq 34.23 }
      end

      describe '#date_time' do
        subject(:value) { example_instance.date_time }

        it { is_expected.to eq example_time }
      end

      describe '#float' do
        subject(:value) { example_instance.float }

        it { is_expected.to eq 2_434_242.221 }
      end

      describe '#int' do
        subject(:value) { example_instance.int }

        it { is_expected.to eq 23 }
      end

      describe '#regex' do
        subject(:value) { example_instance.regex }

        it { is_expected.to eq example_regex }

        context 'when the regex is in a string' do
          subject(:value) { example_instance.regex_from_string }

          it { is_expected.to eq example_regex }
        end
      end

      describe '#symbol' do
        subject(:value) { example_instance.symbol }

        it { is_expected.to eq :hello_world }

        context 'when the symbol is in a string' do
          subject(:value) { example_instance.symbol_string }

          it { is_expected.to eq :hello_world }
        end
      end

      describe '#ensured_string' do
        subject(:ensured_string) { example_instance.ensured_string }

        context 'when the value is specified' do
          let(:attribute_hash) do
            { ensured: 'Some value' }
          end

          it { is_expected.to eq 'Some value' }
        end

        context 'when the value is not specified' do
          let(:attribute_hash) do
            { some_other_key: 'hello' }
          end

          it { is_expected.to eq 'Hello' }
        end
      end
    end
  end
end
