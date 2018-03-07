require 'spec_helper'

RSpec.describe Mailgun::Tracking::Notifier do
  subject(:notifier) { described_class.new(listener) }

  let(:listener) { instance_double(Mailgun::Tracking::Listener) }

  describe '#empty?' do
    context 'when there is at least one subscriber' do
      let(:subscriber) { instance_double(Mailgun::Tracking::Subscriber::AllMessages) }

      before { allow(listener).to receive(:subscribers).and_return([subscriber]) }

      it { is_expected.not_to be_empty }
    end

    context 'when there are no subscribers' do
      before { allow(listener).to receive(:subscribers).and_return([]) }

      it { is_expected.to be_empty }
    end
  end

  describe '#subscribe' do
    let(:callable) { proc {} }

    before { allow(listener).to receive(:add_subscriber) }

    it 'subscribes on event' do
      notifier.subscribe(:delivered, callable)

      expect(listener).to have_received(:add_subscriber)
        .with(:delivered, callable)
    end
  end

  describe '#all' do
    let(:callable) { proc {} }

    before { allow(listener).to receive(:add_subscriber) }

    it 'subscribes on all events' do
      notifier.all(callable)

      expect(listener).to have_received(:add_subscriber).with(nil, callable)
    end
  end

  describe '#broadcast' do
    let(:payload) { fixture('delivered.json') }

    before do
      allow(Mailgun::Tracking::Signature).to receive(:verify!)
      allow(listener).to receive(:broadcast)
      notifier.broadcast(:delivered, payload)
    end

    it 'verify signature' do
      expect(Mailgun::Tracking::Signature).to have_received(:verify!).with(payload)
    end

    it 'broadcasts an event' do
      expect(listener).to have_received(:broadcast).with(:delivered, payload)
    end
  end
end
