# frozen_string_literal: true

RSpec.shared_examples 'subscriber' do
  describe '#call' do
    let(:callable) { proc {} }
    let(:payload) { fixture('legacy/delivered.json') }

    before { allow(callable).to receive(:call).with(payload) }

    it 'calls the callable' do
      subscriber.call(payload)

      expect(callable).to have_received(:call).with(payload)
    end
  end
end
