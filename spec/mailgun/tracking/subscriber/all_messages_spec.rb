require 'spec_helper'

RSpec.describe Mailgun::Tracking::Subscriber::AllMessages do
  subject(:all_events) { described_class.new(callable) }

  let(:callable) { proc {} }

  describe '#call' do
    let(:payload) { fixture('delivered.json') }

    before { allow(callable).to receive(:call).with(payload) }

    it 'calls the callable' do
      all_events.call(payload)

      expect(callable).to have_received(:call).with(payload)
    end
  end

  describe '#subscribed_to?' do
    it { is_expected.to be_subscribed_to(:any_event) }
  end
end
