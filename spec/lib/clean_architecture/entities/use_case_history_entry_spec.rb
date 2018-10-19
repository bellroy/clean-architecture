# frozen_string_literal: true

require 'clean_architecture/entities/failure_details'
require 'clean_architecture/entities/use_case_history_entry'
require 'clean_architecture/interfaces/authorization_parameters'
require 'clean_architecture/interfaces/base_parameters'
require 'clean_architecture/interfaces/use_case_actor'
require 'clean_architecture/interfaces/use_case_history_entry'
require 'clean_architecture/interfaces/use_case_target'
require 'clean_architecture/interfaces/use_case'
require 'dry/monads/all'

module CleanArchitecture
  module Entities
    describe UseCaseHistoryEntry do
      let(:use_case_history_entry) do
        described_class.new(use_case, use_case_target)
      end

      let(:use_case) do
        instance_double(
          Interfaces::UseCase,
          parameters: use_case_parameters,
          result: use_case_result
        )
      end
      let(:use_case_parameters) do
        instance_double(
          Interfaces::AuthorizationParameters,
          actor: actor,
          extra_parameters_hash: { extra_parameters: :hash }
        )
      end
      let(:use_case_result) { Dry::Monads::Failure('error!') }
      let(:use_case_target) do
        instance_double(
          Interfaces::UseCaseTarget,
          identifier: :smeagol,
          attribute_hash: { prior: :target_state }
        )
      end

      let(:actor) { instance_double(Interfaces::UseCaseActor, user_identifier: 'bob') }

      it_behaves_like 'it implements', Interfaces::UseCaseHistoryEntry

      describe '#failure_messages' do
        subject(:failure_messages) { use_case_history_entry.failure_messages }

        it { is_expected.to eq 'error!' }

        context do
          let(:use_case_result) { Dry::Monads::Success('something') }

          it { is_expected.to be_nil }
        end

        context do
          let(:use_case_result) do
            failure_details = FailureDetails.new(
              type: 'unauthorized',
              message: 'Unauthorized',
              other_properties: {}
            )
            Dry::Monads::Failure(failure_details)
          end

          it { is_expected.to eq 'Unauthorized' }
        end
      end

      describe '#target_identifier' do
        subject(:target_identifier) { use_case_history_entry.target_identifier }

        it { is_expected.to eq :smeagol }
      end

      describe '#extra_parameters_hash' do
        subject(:extra_parameters_hash) { use_case_history_entry.extra_parameters_hash }

        it { is_expected.to eq(extra_parameters: :hash) }
      end

      describe '#prior_target_state' do
        subject(:prior_target_state) { use_case_history_entry.prior_target_state }

        it { is_expected.to eq(prior: :target_state) }
      end

      describe '#succeeded?' do
        subject(:succeeded?) { use_case_history_entry.succeeded? }

        it { is_expected.to be false }
      end

      describe '#use_case_class_name' do
        subject(:use_case_class_name) { use_case_history_entry.use_case_class_name }

        it { is_expected.to eq use_case.class.name }
      end

      describe '#user_identifier' do
        subject(:user_identifier) { use_case_history_entry.user_identifier }

        it { is_expected.to eq 'bob' }
      end
    end
  end
end
