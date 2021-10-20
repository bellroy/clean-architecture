# typed: false
# frozen_string_literal: true

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
          let(:failure_details) do
            Entities::FailureDetails.new(
              message: 'failure!',
              type: Entities::FailureType::Unauthorized
            )
          end
          let(:result) { Dry::Monads::Failure(failure_details) }

          it { is_expected.to eq failure_details }
        end
      end
    end
  end
end
