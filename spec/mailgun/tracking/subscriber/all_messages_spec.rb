require 'spec_helper'

RSpec.describe Mailgun::Tracking::Subscriber::AllMessages do
  subject(:subscriber) { described_class.new(callable) }

  it_behaves_like :subscriber

  describe '#subscribed_to?' do
    let(:callable) { proc {} }

    it { is_expected.to be_subscribed_to(:any_event) }
  end
end
