# frozen_string_literal: true

require 'clean_architecture/interfaces/authorization_check'
require 'clean_architecture/interfaces/command'
require 'clean_architecture/interfaces/strategy'
require 'clean_architecture/strategies/actor_gets_authorized_then_does_work'

module CleanArchitecture
  module Strategies
    describe ActorGetsAuthorizedThenDoesWork do
      let(:strategy) do
        described_class.new(authorization_check, command)
      end

      let(:authorization_check) do
        instance_double(Interfaces::AuthorizationCheck, authorized?: authorized?)
      end
      let(:command) { instance_double(Interfaces::Command, result: command_result) }
      let(:command_result) { Dry::Monads::Success(nil) }

      describe '#result' do
        subject(:result) { strategy.result }

        context do
          let(:authorized?) { true }

          it { is_expected.to eq command_result }
        end

        context do
          let(:authorized?) { false }

          specify do
            expect(result).to be_a Dry::Monads::Failure
            expect(result.failure).to eq 'Unauthorized'
          end
        end
      end
    end
  end
end
