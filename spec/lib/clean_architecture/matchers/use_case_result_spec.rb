# typed: false
# frozen_string_literal: true

require 'clean_architecture/matchers/use_case_result'

module CleanArchitecture
  module Matchers
    describe UseCaseResult do
      describe '.call' do
        subject(:call) do
          described_class.call(result) do |matcher|
            matcher.success(&:to_s)
            matcher.failure { |failure_details| failure_details }
          end
        end

        context do
          let(:result) { Dry::Monads::Success('success!') }

          it { is_expected.to eq 'success!' }
        end

        context do
          let(:result) { Dry::Monads::Failure('failure!') }

          specify do
            expect(call).to eq Entities::FailureDetails.new(
              message: 'failure!',
              other_properties: {},
              type: 'error'
            )
          end
        end

        context do
          let(:result) { Dry::Monads::Failure(['failure 1', 'failure 2']) }

          specify do
            expect(call).to eq Entities::FailureDetails.new(
              message: 'failure 1, failure 2',
              other_properties: {},
              type: 'error'
            )
          end
        end

        context do
          let(:failure_details) do
            Entities::FailureDetails.new(
              message: 'failure!',
              other_properties: { a: :b },
              type: 'unauthorized'
            )
          end
          let(:result) { Dry::Monads::Failure(failure_details) }

          it { is_expected.to eq failure_details }
        end

        context do
          let(:result) { Dry::Monads::Failure(:no) }

          specify { expect { call }.to raise_error ArgumentError }
        end
      end
    end
  end
end
