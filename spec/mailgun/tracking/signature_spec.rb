require 'spec_helper'

RSpec.describe Mailgun::Tracking::Signature do
  subject(:signature) { described_class.new(payload) }

  let(:payload) { fixture('delivered.json') }

  describe '.verify!' do
    context 'when the signature comparison is successful' do
      it { expect(described_class.verify!(payload)).to be true }
    end

    context 'when the signature comparison is unsuccessful' do
      before { payload.merge!('timestamp' => '') }

      it { expect { described_class.verify!(payload) }.to raise_error(Mailgun::Tracking::InvalidSignature) }
    end
  end

  describe '#valid?' do
    context 'when the signature comparison is successful' do
      it { is_expected.to be_valid }
    end

    context 'when the signature comparison is unsuccessful' do
      before { payload.merge!('timestamp' => '') }

      it { is_expected.not_to be_valid }
    end
  end
end
