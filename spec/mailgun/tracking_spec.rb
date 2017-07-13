require 'spec_helper'

RSpec.describe Mailgun::Tracking do
  describe '.configure' do
    it 'setup block yields self' do
      described_class.configure do |config|
        expect(described_class).to eq(config)
      end
    end
  end

  describe '.subscribe' do
    let(:listener) { instance_double(Mailgun::Tracking::Listener) }

    before do
      described_class.clear_cached_variables
      allow(listener).to receive(:add_subscriber)
      allow(Mailgun::Tracking::Listener).to receive(:new) { listener }
    end

    it 'subscribes on event' do
      described_class.subscribe(:delivered) {}

      expect(listener).to have_received(:add_subscriber)
        .with(:delivered)
    end
  end

  describe '.broadcast' do
    let(:payload) { fixture('delivered.json') }
    let(:listener) { instance_double(Mailgun::Tracking::Listener) }

    before do
      described_class.clear_cached_variables
      allow(Mailgun::Tracking::Signature).to receive(:verify!)
      allow(listener).to receive(:broadcast)
      allow(Mailgun::Tracking::Listener).to receive(:new) { listener }
      described_class.broadcast(:delivered, payload)
    end

    it 'verify signature' do
      expect(Mailgun::Tracking::Signature).to have_received(:verify!).with(payload)
    end

    it 'broadcasts an event' do
      expect(listener).to have_received(:broadcast).with(:delivered, payload)
    end
  end
end
