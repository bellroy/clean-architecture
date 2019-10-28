# typed: ignore
# frozen_string_literal: true

require 'net/http'
require 'clean_architecture/use_cases/abstract_use_case'
require 'dry/monads/do'

module CleanArchitecture
  module UseCases
    describe AbstractUseCase do
      class ExampleSharedContract < Contract
        register_macro(:check_with_an_external_system) do
          key.failure('is on the troublemaker list') if values[key_name] == 'mike@bellroy.com'
        end
      end

      class UnrelatedUseCase < AbstractUseCase
        contract(ExampleSharedContract) do
          params do
            required(:name).filled(:str?)
          end
        end
      end

      class ExampleUseCase < AbstractUseCase
        contract(ExampleSharedContract) do
          option :some_api

          params do
            required(:email).filled(:str?)
            required(:age).filled(:int?, gt?: 18)
          end

          rule(:email).validate(:check_with_an_external_system)
        end

        include Dry::Monads::Do.for(:result)

        EMAILS_OF_TROLLS = %w[
          sam@samuelgil.es
        ]

        def result
          valid_params = yield result_of_validating_params
          allowed_email = yield result_of_checking_against_banned_user_list(valid_params[:email])

          context(:some_api).new('http://google.com/')

          Dry::Monads::Success("Welcome #{allowed_email}!")
        end

        private

        def result_of_checking_against_banned_user_list(email)
          return Dry::Monads::Success(email) unless EMAILS_OF_TROLLS.include?(email)

          fail_with_error_message('Your email address is banned', 'expectation_failed')
        end
      end

      subject(:result) do
        ExampleUseCase.new(params).result
      end

      let(:params) do
        ExampleUseCase.parameters(
          context: { some_api: some_api },
          email: email,
          age: age
        )
      end
      let(:some_api) { class_double(Net::HTTP) }

      describe '#result_of_validating_params' do
        let(:email) { 'samuel.giles@bellroy.com' }

        context 'when params are invalid' do
          let(:age) { 17 }

          specify do
            expect(result).to be_an_instance_of(Dry::Monads::Failure)
            expect(result.failure).to be_an_instance_of(Errors)
            expect(result.failure.full_messages).to eq(
              ['Age must be greater than 18']
            )
          end
        end

        context 'when params are invalid based on a shared macro' do
          let(:age) { 20 }
          let(:email) { 'mike@bellroy.com' }

          specify do
            expect(result).to be_an_instance_of(Dry::Monads::Failure)
            expect(result.failure).to be_an_instance_of(Errors)
            expect(result.failure.full_messages).to eq(
              ['Email is on the troublemaker list']
            )
          end
        end

        context 'when params are valid' do
          let(:age) { 20 }

          specify do
            expect(some_api).to receive(:new).with('http://google.com/')
            expect(result).to be_an_instance_of(Dry::Monads::Success)
            expect(result.value!).to eq "Welcome samuel.giles@bellroy.com!"
          end
        end
      end

      describe '#fail_with_error_message' do
        let(:age) { 20 }
        let(:email) { 'sam@samuelgil.es' }

        specify do
          expect(result).to be_an_instance_of(Dry::Monads::Failure)
          expect(result.failure).to be_an_instance_of(Errors)
          expect(result.failure.full_messages).to eq(
            ['Your email address is banned']
          )
        end
      end
    end
  end
end
