# frozen_string_literal: true

require 'clean_architecture/interfaces/success_object_payload'
require 'clean_architecture/interfaces/use_case_target'
require 'clean_architecture/serializers/success_object_payload'

module CleanArchitecture
  module Serializers
    describe SuccessObjectPayload do
      let(:success_object_payload) { described_class.new(use_case_target, version) }

      let(:use_case_target) do
        instance_double(
          CleanArchitecture::Interfaces::UseCaseTarget,
          identifier: 'B0000123',
          attribute_hash: { prior: :state_hash },
          type_name: 'SalesOrder'
        )
      end
      let(:version) { '1.0' }

      describe '#data_hash' do
        subject(:data_hash) { success_object_payload.data_hash }

        specify do
          expect(data_hash).to eq(
            type: 'SalesOrder',
            id: 'B0000123',
            attributes: { prior: :state_hash }
          )
        end
      end
    end
  end
end
