# typed: false
# frozen_string_literal: true

require 'dry/monads/all'

module CleanArchitecture
  module Serializers
    describe JsonResponseFromResult do
      let(:json_response_from_result) { described_class.new(result, http_method, success_payload_proc) }

      let(:result) { Dry::Monads::Success('attributes') }
      let(:http_method) { 'GET' }
      let(:success_payload_proc) do
          Proc.new { |value| { some: value } }
      end

      describe '#to_h' do
        subject(:to_h) { json_response_from_result.to_h }

        specify do
          expect(to_h).to eq(
            status: :ok,
            json: { data: { some: 'attributes' } }
          )
        end

        context do
          let(:result) { Dry::Monads::Failure('fail!') }

          specify do
            expect(to_h).to eq(
              status: :internal_server_error,
              json: { errors: ['fail!'] }
            )
          end
        end

        context do
          let(:http_method) { 'POST' }

          specify do
            expect(to_h).to eq(
              status: :created,
              json: { data: { some: 'attributes' } }
            )
          end
        end

        context do
          let(:result) { Dry::Monads::Failure('Unauthorized: get out my house') }

          specify do
            expect(to_h).to eq(
              status: :internal_server_error,
              json: { errors: ['Unauthorized: get out my house'] }
            )
          end
        end

        context do
          let(:failure_details) do
            Entities::FailureDetails.new(
              message: 'Something bad happened!',
              type: Entities::FailureType::Error
            )
          end
          let(:result) { Dry::Monads::Failure(failure_details) }

          specify do
            expect(to_h).to eq(
              status: :internal_server_error,
              json: { errors: ['Something bad happened!'] }
            )
          end
        end
      end
    end
  end
end
