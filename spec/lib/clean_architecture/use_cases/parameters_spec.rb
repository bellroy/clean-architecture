# typed: false
# frozen_string_literal: true

require 'dry-validation'
require 'clean_architecture/use_cases/parameters'

module CleanArchitecture
  module UseCases
    describe Parameters do
      let(:parameters) { described_class.new(context, dry_validation_result) }

      let(:context) do
        { username: 'samuelgiles93' }
      end
      let(:dry_validation_result) { instance_double(Dry::Validation::Result) }

      describe '#context' do
        subject { parameters.context(:username) }

        it { is_expected.to eq 'samuelgiles93' }
      end

      describe '[]' do
        subject { parameters[:password] }

        before do
          expect(dry_validation_result).to receive(:[]).with(:password).and_return('top_secret')
        end

        it { is_expected.to eq 'top_secret' }
      end

      describe '#to_monad' do
        subject(:result) { parameters.to_monad }

        before do
          expect(dry_validation_result)
            .to receive(:success?)
            .and_return(validation_successful)
        end

        context 'when validation was successful' do
          let(:validation_successful) { true }

          before do
            expect(dry_validation_result).to receive(:to_h).and_return(password: 'top_secret')
          end

          specify do
            expect(result).to be_an_instance_of(Dry::Monads::Success)
            expect(result.value!).to eq(password: 'top_secret')
          end
        end

        context "when validation wasn't successful" do
          let(:validation_successful) { false }
          let(:dry_validation_errors) { instance_double(Dry::Validation::MessageSet) }

          before do
            expect(dry_validation_result).to receive(:errors).and_return(dry_validation_errors)
            expect(dry_validation_errors).to receive(:to_h).and_return(password: ['is super lame'])
          end

          specify do
            expect(result).to be_an_instance_of(Dry::Monads::Failure)
            expect(result.failure).to be_an_instance_of(Errors)
            expect(result.failure.full_messages).to eq([
              'Password is super lame'
            ])
          end
        end
      end
    end
  end
end
