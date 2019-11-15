# frozen_string_literal: true

RSpec.describe Mailgun::Tracking::Listener do
  subject(:listener) { described_class.new }

  let(:callable) { proc {} }
  let(:subscriber) { instance_double(Mailgun::Tracking::Subscriber::Evented) }

  describe '#add_subscriber' do
    before { allow(Mailgun::Tracking::Subscriber).to receive(:for).with(/delivered/, callable) { subscriber } }

    it 'adds subscriber' do
      expect { listener.add_subscriber(:delivered, callable) }.to change(listener, :subscribers)
        .from([])
        .to([subscriber])
    end

    it 'adds multiple subscribers with the same name' do
      expect do
        listener.add_subscriber(:delivered, callable)
        listener.add_subscriber('delivered', callable)
      end.to change(listener, :subscribers).from([]).to([subscriber, subscriber])
    end
  end

  describe '#broadcast' do
    let(:payload) { fixture('legacy/delivered.json') }

    before do
      allow(subscriber).to receive(:call)
      allow(subscriber).to receive(:subscribed_to?).with(/delivered/).and_return(true)
      allow(Mailgun::Tracking::Subscriber).to receive(:for).with(:delivered, callable) { subscriber }

      listener.add_subscriber(:delivered, callable)
    end

    it 'executes subscriber' do
      listener.broadcast(:delivered, payload)
      expect(subscriber).to have_received(:call).with(payload)
    end

    it 'executes multiple subscribers' do
      listener.add_subscriber(:delivered, callable)
      listener.broadcast('delivered', payload)
      expect(subscriber).to have_received(:call).with(payload).twice
    end
  end
end
