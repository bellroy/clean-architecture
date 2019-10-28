# typed: false
# frozen_string_literal: true

shared_examples_for 'an interface' do
  class Dummy
    def initialize; end
  end

  context 'when all methods raise NotImplementedError' do
    before do
      Dummy.include described_class
    end

    let(:dummy) { Dummy.new }

    specify do
      described_class.instance_methods.each do |method|
        fail_message = "#{method} is not abstract"
        parameters = dummy.method(method).parameters
        if parameters.empty?
          expect { dummy.send(method) }.to raise_error(NotImplementedError), fail_message
        else
          nils = parameters.map { |_| nil }
          expect { dummy.send(method, *nils) }.to raise_error(NotImplementedError), fail_message
        end
      end
    end
  end
end
