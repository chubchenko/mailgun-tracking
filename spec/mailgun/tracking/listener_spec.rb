require 'spec_helper'

RSpec.describe Mailgun::Tracking::Listener do
  subject(:listener) { described_class.new }

  let(:block) { proc {} }

  describe '#add_subscriber' do
    it 'adds subscriber' do
      expect { listener.add_subscriber(:delivered, &block) }.to change(listener, :subscribers)
        .from({})
        .to(delivered: [block])
    end

    it 'adds multiple subscribers with the same name' do
      expect do
        listener.add_subscriber(:delivered, &block)
        listener.add_subscriber('delivered', &block)
      end.to change(listener, :subscribers).from({}).to(delivered: [block, block])
    end
  end

  describe '#broadcast' do
    let(:payload) { fixture('delivered.json') }

    before do
      allow(block).to receive(:call)
      listener.add_subscriber(:delivered, &block)
    end

    it 'executes block' do
      listener.broadcast(:delivered, payload)
      expect(block).to have_received(:call).with(payload)
    end

    it 'executes multiple blocks' do
      listener.add_subscriber(:delivered, &block)
      listener.broadcast('delivered', payload)
      expect(block).to have_received(:call).with(payload).twice
    end
  end
end
