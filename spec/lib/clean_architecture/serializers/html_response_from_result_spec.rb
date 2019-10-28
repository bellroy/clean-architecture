# typed: false
# frozen_string_literal: true

require 'clean_architecture/serializers/html_response_from_result'
require 'dry/monads/all'

module CleanArchitecture
  module Serializers
    describe HtmlResponseFromResult do
      let(:html_response_from_result) { described_class.new(result, http_method) }

      let(:http_method) { 'get' }

      describe '#to_h' do
        subject(:to_h) { html_response_from_result.to_h }

        context do
          let(:result) { Dry::Monads::Success('something') }

          it { is_expected.to eq(data: 'something', status: :ok) }
        end

        context do
          let(:result) { Dry::Monads::Failure('something') }

          it { is_expected.to eq(error: 'something', status: :internal_server_error) }
        end

        context do
          let(:failure_details) do
            Entities::FailureDetails.new(
              message: 'Unauthorized',
              other_properties: {},
              type: 'unauthorized'
            )
          end
          let(:result) { Dry::Monads::Failure(failure_details) }

          it { is_expected.to eq(error: 'Unauthorized', status: :unauthorized) }
        end

        context do
          let(:failure_details) do
            Entities::FailureDetails.new(
              message: 'Something bad happened',
              other_properties: {},
              type: 'error'
            )
          end
          let(:result) { Dry::Monads::Failure(failure_details) }

          it { is_expected.to eq(error: 'Something bad happened', status: :internal_server_error) }
        end
      end
    end
  end
end
