require 'spec_helper'

RSpec.describe Mailgun::Tracking::Notifier do
  subject(:notifier) { described_class.new(listener) }

  let(:listener) { instance_double(Mailgun::Tracking::Listener) }

  describe '#subscribe' do
    let(:subscriber) { proc {} }
    let(:subscriber_adapter) { instance_double(Mailgun::Tracking::SubscriberAdapter) }

    before do
      allow(listener).to receive(:add_subscriber)
      allow(Mailgun::Tracking::Listener).to receive(:new) { listener }
      allow(Mailgun::Tracking::SubscriberAdapter).to receive(:call).with(subscriber) { subscriber_adapter }
    end

    it 'wraps subscriber' do
      notifier.subscribe(:delivered, subscriber)

      expect(Mailgun::Tracking::SubscriberAdapter).to have_received(:call).with(subscriber)
    end

    it 'subscribes on event' do
      notifier.subscribe(:delivered, subscriber)

      expect(listener).to have_received(:add_subscriber)
        .with(:delivered, subscriber_adapter)
    end
  end

  describe '#all' do
    let(:subscriber) { proc {} }
    let(:subscriber_adapter) { instance_double(Mailgun::Tracking::SubscriberAdapter) }

    before do
      allow(listener).to receive(:add_subscriber)
      allow(Mailgun::Tracking::Listener).to receive(:new) { listener }
      allow(Mailgun::Tracking::SubscriberAdapter).to receive(:call).with(subscriber) { subscriber_adapter }
    end

    it 'wraps subscriber' do
      notifier.all(subscriber)

      expect(Mailgun::Tracking::SubscriberAdapter).to have_received(:call).with(subscriber)
    end

    it 'subscribes on all events' do
      notifier.all(subscriber)

      expect(listener).to have_received(:add_subscriber)
        .with(nil, subscriber_adapter)
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
