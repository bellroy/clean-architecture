# frozen_string_literal: true

require 'clean_architecture/use_cases/form'
require 'clean_architecture/use_cases/abstract_use_case'

module CleanArchitecture
  module UseCases
    describe Form do
      class ExampleGateway
        def example_lookup(value)
          true
        end
      end

      class ExampleUseCase < AbstractUseCase
        params do
          configure do
            option :some_gateway

            def some_custom_predicate?(value)
              some_gateway.example_lookup(value)
            end
          end

          required(:email).filled(:str?, :some_custom_predicate?)
          required(:age).filled(:int?, gt?: 18)
        end
      end

      class ExampleForm < Form
        acts_as_form_for ExampleUseCase
      end

      describe '.acts_as_form_for' do
        subject(:form) do
          ExampleForm.new(
            params: { 'email' => 'samuel.giles@bellroy.com', 'age' => 26 },
            context: { some_gateway: ExampleGateway.new }
          )
        end

        specify do
          expect(form.email).to eq 'samuel.giles@bellroy.com'
          expect(form.age).to eq 26
          expect(form.use_case_class).to eq ExampleUseCase
        end
      end

      describe '#to_parameter_object' do
        subject(:parameter_object) do
          ExampleForm.new(
            params: { 'email' => 'samuel.giles@bellroy.com', 'age' => 26 },
            context: { some_gateway: ExampleGateway.new }
          ).to_parameter_object
        end

        specify do
          expect(parameter_object).to be_an_instance_of(Dry::Validation::Result)
          expect(parameter_object.errors).to be_empty
          expect(parameter_object[:email]).to eq 'samuel.giles@bellroy.com'
          expect(parameter_object[:age]).to eq 26
        end
      end

      describe '#with_errors' do
        subject(:form_with_errors) do
          ExampleForm.new(
            params: { 'email' => 'samuel.giles@bellroy.com', 'age' => 26 },
            context: { some_gateway: ExampleGateway.new }
          ).with_errors(errors)
        end

        let(:errors) do
          new_errors = Errors.new(nil)
          new_errors.add(:email, 'is banned')
          new_errors.add(:age, 'is way too old')
          new_errors
        end

        specify do
          expect(form_with_errors).to be_an_instance_of(ExampleForm)
          expect(form_with_errors.email).to eq 'samuel.giles@bellroy.com'
          expect(form_with_errors.errors.full_messages).to contain_exactly(
            'Email is banned',
            'Age is way too old'
          )
        end

        context 'when the errors are in the form of a FailureDetails instance' do
          let(:errors) do
            Entities::FailureDetails.new(
              type: 'not_found',
              message: 'The order no longer exists',
              other_properties: { some_metadata: 'that will be discarded' }
            )
          end

          specify do
            expect(form_with_errors).to be_an_instance_of(ExampleForm)
            expect(form_with_errors.email).to eq 'samuel.giles@bellroy.com'
            expect(form_with_errors.errors.full_messages).to contain_exactly(
              'The order no longer exists'
            )
          end
        end

        context 'when the errors are in the form of a String' do
          let(:errors) do
            'Someone passed back a string in a Dry::Monads::Failure!'
          end

          specify do
            expect(form_with_errors).to be_an_instance_of(ExampleForm)
            expect(form_with_errors.email).to eq 'samuel.giles@bellroy.com'
            expect(form_with_errors.errors.full_messages).to contain_exactly(
              'Someone passed back a string in a Dry::Monads::Failure!'
            )
          end
        end
      end

      describe '#with_error_message' do
        subject(:form_with_error_message) do
          ExampleForm.new(
            params: { 'email' => 'samuel.giles@bellroy.com', 'age' => 26 },
            context: { some_gateway: ExampleGateway.new }
          ).with_error_message('Something is offline')
        end

        specify do
          expect(form_with_error_message).to be_an_instance_of(ExampleForm)
          expect(form_with_error_message.errors.full_messages).to contain_exactly('Something is offline')
        end
      end
    end
  end
end
