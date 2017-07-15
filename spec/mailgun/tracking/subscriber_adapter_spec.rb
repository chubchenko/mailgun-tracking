require 'spec_helper'

RSpec.describe Mailgun::Tracking::SubscriberAdapter do
  subject(:subscriber_adapter) { described_class.new(callable) }

  describe '.call' do
    let(:callable) { proc {} }

    it 'returns SubscriberAdapter instance' do
      expect(described_class.call(callable)).to an_instance_of(described_class)
    end
  end

  describe '#call' do
    let(:callable) { double(:callable) }
    let(:payload) { fixture('delivered.json') }

    before do
      allow(callable).to receive(:call).with(payload)
    end

    it 'calls the callable' do
      subscriber_adapter.call(payload)

      expect(callable).to have_received(:call).with(payload)
    end
  end
end
