# typed: false
# frozen_string_literal: true

require 'dry/monads/all'

module CleanArchitecture
  module Checks
    class AlwaysAuthorized < Authorization
      def authorized?
        true
      end
    end

    class AlwaysUnauthorized < Authorization
      def authorized?
        false
      end
    end

    describe Authorization do
      let(:authorization) { authorization_class.new }

      describe '#result' do
        subject(:result) { authorization.result }

        context do
          let(:authorization_class) { AlwaysAuthorized }

          it { is_expected.to be_success }
        end

        context do
          let(:authorization_class) { AlwaysUnauthorized }

          specify do
            expect(result).to be_a Dry::Monads::Failure
            expect(result.failure).to eq Entities::FailureDetails.new(
              message: 'Unauthorized',
              type: Entities::FailureType::Unauthorized
            )
          end
        end
      end
    end
  end
end
