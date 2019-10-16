# frozen_string_literal: true

RSpec.describe Mailgun::Tracking::Subscriber::Evented do
  subject(:subscriber) { described_class.new('delivered', callable) }

  it_behaves_like 'subscriber'

  describe '#subscribed_to?' do
    let(:callable) { proc {} }

    it { is_expected.to be_subscribed_to(:delivered) }
    it { is_expected.not_to be_subscribed_to(:any_event) }
  end
end
