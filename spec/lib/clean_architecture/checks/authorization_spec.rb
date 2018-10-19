# frozen_string_literal: true

require 'clean_architecture/checks/authorization'
require 'dry/monads/all'

module CleanArchitecture
  module Checks
    describe Authorization do
      let(:authorization) { described_class.new }

      describe '#result' do
        subject(:result) { authorization.result }

        before { expect(authorization).to receive(:authorized?).and_return(authorized?) }

        context do
          let(:authorized?) { true }

          it { is_expected.to be_success }
        end

        context do
          let(:authorized?) { false }

          specify do
            expect(result).to be_a Dry::Monads::Failure
            expect(result.failure).to eq Entities::FailureDetails.new(
              message: 'Unauthorized',
              other_properties: {},
              type: 'unauthorized'
            )
          end
        end
      end
    end
  end
end
