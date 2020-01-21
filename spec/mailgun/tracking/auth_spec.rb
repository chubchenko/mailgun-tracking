# frozen_string_literal: true

RSpec.describe Mailgun::Tracking::Auth do
  let(:payload) { fixture('delivered.json') }

  describe '.call' do
    let(:auth) { instance_double(described_class) }

    before do
      allow(described_class).to receive(:new).and_return(auth).with(payload)
      allow(auth).to receive(:valid?).and_return(true)
      described_class.call(payload)
    end

    it { expect(auth).to have_received(:valid?) }
  end

  describe '#valid?' do
    subject(:auth) { described_class.new(payload) }

    context 'when the signature comparison is successful' do
      it { is_expected.to be_valid }
    end

    context 'when the signature comparison is unsuccessful' do
      before { payload['signature']['timestamp'] = '' }

      it { is_expected.not_to be_valid }
    end
  end
end
