# frozen_string_literal: true

require 'clean_architecture/interfaces/success_payload'
require 'clean_architecture/serializers/json_response_from_result'

module CleanArchitecture
  module Serializers
    describe JsonResponseFromResult do
      let(:json_response_from_result) { described_class.new(result, http_method, success_payload) }

      let(:result) { Dry::Monads::Success(nil) }
      let(:http_method) { 'GET' }
      let(:success_payload) do
        instance_double(
          Interfaces::SuccessPayload,
          data_hash: { some: 'attributes' },
          version: '1.0'
        )
      end

      describe '#to_h' do
        subject(:to_h) { json_response_from_result.to_h }

        specify do
          expect(to_h).to eq(
            status: :ok,
            json: { jsonapi: { version: '1.0' }, data: { some: 'attributes' } }
          )
        end

        context do
          let(:result) { Dry::Monads::Failure('fail!') }

          specify do
            expect(to_h).to eq(
              status: :expectation_failed,
              json: { jsonapi: { version: '1.0' }, errors: ['fail!'] }
            )
          end
        end

        context do
          let(:http_method) { 'POST' }

          specify do
            expect(to_h).to eq(
              status: :created,
              json: { jsonapi: { version: '1.0' }, data: { some: 'attributes' } }
            )
          end
        end

        context do
          let(:result) { Dry::Monads::Failure('Unauthorized: get out my house') }

          specify do
            expect(to_h).to eq(
              status: :unauthorized,
              json: { jsonapi: { version: '1.0' }, errors: ['Unauthorized: get out my house'] }
            )
          end
        end
      end
    end
  end
end
