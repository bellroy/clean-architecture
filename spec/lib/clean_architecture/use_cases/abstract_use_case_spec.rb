# frozen_string_literal: true

require 'clean_architecture/use_cases/abstract_use_case'
require 'dry/monads/do'

module CleanArchitecture
  module UseCases
    describe AbstractUseCase do
      class ExampleUseCase < AbstractUseCase
        params do
          required(:email).filled(:str?)
          required(:age).filled(:int?, gt?: 18)
        end

        include Dry::Monads::Do.for(:result)

        def initialize(parameters)
          @parameters = parameters
        end

        EMAILS_OF_TROLLS = %w[
          sam@samuelgil.es
        ]

        def result
          valid_params = yield result_of_validating_params(@parameters)
          allowed_email = yield result_of_checking_against_banned_user_list(valid_params[:email])

          Dry::Monads::Success("Welcome #{allowed_email}!")
        end

        private

        def result_of_checking_against_banned_user_list(email)
          return Dry::Monads::Success(email) unless EMAILS_OF_TROLLS.include?(email)

          fail_with_error_message('Your email address is banned', 'expectation_failed')
        end
      end

      subject(:result) do
        ExampleUseCase.new(parameters).result
      end

      let(:parameters) do
        ExampleUseCase.params.call(
          email: email,
          age: age
        )
      end

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

        context 'when params are valid' do
          let(:age) { 20 }

          specify do
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
