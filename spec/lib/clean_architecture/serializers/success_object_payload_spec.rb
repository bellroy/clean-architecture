# typed: false
# frozen_string_literal: true

require 'clean_architecture/interfaces/success_payload'
require 'clean_architecture/interfaces/use_case_target'
require 'clean_architecture/serializers/success_payload'

module CleanArchitecture
  module Serializers
    describe SuccessPayload do
      let(:success_payload) { described_class.new(use_case_target) }

      let(:use_case_target) do
        instance_double(
          CleanArchitecture::Interfaces::UseCaseTarget,
          identifier: 'B0000123',
          attribute_hash: { prior: :state_hash },
          type_name: 'SalesOrder'
        )
      end

      describe '#data' do
        subject(:data) { success_payload.data }

        specify do
          expect(data).to eq(
            type: 'SalesOrder',
            id: 'B0000123',
            attributes: { prior: :state_hash }
          )
        end
      end
    end
  end
end
