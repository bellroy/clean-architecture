# frozen_string_literal: true

require 'clean_architecture/interfaces/success_payload'
require 'clean_architecture/interfaces/use_case_target'
require 'clean_architecture/serializers/success_collection_payload'

class MockUseCaseTarget
  implements_interface CleanArchitecture::Interfaces::UseCaseTarget

  def initialize(object)
    @object = object
  end

  def type_name
    'mock_object'
  end

  def identifier
    'some_id'
  end

  def attribute_hash
    { attribute: @object.some_attribute }
  end
end

class MockObject
  def some_attribute
    "attribute_value"
  end
end

module CleanArchitecture
  module Serializers
    describe SuccessCollectionPayload do
      let(:success_collection_payload) { described_class.new(collection, use_case_target_class) }

      let(:collection) do
        [MockObject.new]
      end

      let(:use_case_target_class) { MockUseCaseTarget }

      describe '#data' do
        subject(:data) { success_collection_payload.data }

        specify do
          expect(data).to eq([
            {
              attributes: {
                attribute: "attribute_value"
              },
              id: "some_id",
              type: "mock_object"
            }
          ])
        end
      end
    end
  end
end
