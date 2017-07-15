require 'spec_helper'

RSpec.describe Mailgun::Tracking::Listener do
  subject(:listener) { described_class.new }

  let(:subscriber_adapter) { instance_double(Mailgun::Tracking::SubscriberAdapter) }

  describe '#add_subscriber' do
    it 'adds subscriber' do
      expect { listener.add_subscriber(:delivered, subscriber_adapter) }.to change(listener, :subscribers)
        .from({})
        .to(delivered: [subscriber_adapter])
    end

    it 'adds multiple subscribers with the same name' do
      expect do
        listener.add_subscriber(:delivered, subscriber_adapter)
        listener.add_subscriber('delivered', subscriber_adapter)
      end.to change(listener, :subscribers).from({}).to(delivered: [subscriber_adapter, subscriber_adapter])
    end
  end

  describe '#broadcast' do
    let(:payload) { fixture('delivered.json') }

    before do
      allow(subscriber_adapter).to receive(:call)
      listener.add_subscriber(:delivered, subscriber_adapter)
    end

    it 'executes subscriber' do
      listener.broadcast(:delivered, payload)
      expect(subscriber_adapter).to have_received(:call).with(payload)
    end

    it 'executes multiple subscribers' do
      listener.add_subscriber(:delivered, subscriber_adapter)
      listener.broadcast('delivered', payload)
      expect(subscriber_adapter).to have_received(:call).with(payload).twice
    end
  end
end
