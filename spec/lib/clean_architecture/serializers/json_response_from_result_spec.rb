# frozen_string_literal: true

require 'clean_architecture/interfaces/success_object_payload'
require 'clean_architecture/serializers/json_response_from_result'
require 'dry/monads/all'

module CleanArchitecture
  module Serializers
    describe JsonResponseFromResult do
      let(:json_response_from_result) { described_class.new(result, http_method, success_object_payload) }

      let(:result) { Dry::Monads::Success(nil) }
      let(:http_method) { 'GET' }
      let(:success_object_payload) do
        instance_double(
          Interfaces::SuccessObjectPayload,
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
              status: :internal_server_error,
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
              status: :internal_server_error,
              json: { jsonapi: { version: '1.0' }, errors: ['Unauthorized: get out my house'] }
            )
          end
        end

        context do
          let(:failure_details) do
            Entities::FailureDetails.new(
              message: 'Something bad happened!',
              other_properties: {},
              type: 'error'
            )
          end
          let(:result) { Dry::Monads::Failure(failure_details) }

          specify do
            expect(to_h).to eq(
              status: :internal_server_error,
              json: { jsonapi: { version: '1.0' }, errors: ['Something bad happened!'] }
            )
          end
        end
      end
    end
  end
end
