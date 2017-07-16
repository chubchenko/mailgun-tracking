require 'spec_helper'

RSpec.describe Mailgun::Tracking::Subscriber::Evented do
  subject(:evented) { described_class.new('delivered', callable) }

  let(:callable) { proc {} }

  describe '#call' do
    let(:payload) { fixture('delivered.json') }

    before { allow(callable).to receive(:call).with(payload) }

    it 'calls the callable' do
      evented.call(payload)

      expect(callable).to have_received(:call).with(payload)
    end
  end

  describe '#subscribed_to?' do
    it { is_expected.to be_subscribed_to(:delivered) }
    it { is_expected.not_to be_subscribed_to(:any_event) }
  end
end
