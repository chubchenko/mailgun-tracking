# frozen_string_literal: true

RSpec.describe Mailgun::Tracking::Signature do
  subject(:signature) { described_class.new(payload) }

  describe '.verify!' do
    context 'when the signature comparison is successful' do
      let(:payload) do
        instance_double(
          Mailgun::Tracking::Payload,
          timestamp: '1499697910',
          token: 'b5751a49a024483da8d41c3684f98b8f',
          signature: '374e0b1a3deeb57318c783d43ff71093fbf26406a452761dab91bf346a93b49e'
        )
      end

      it { expect(described_class.verify!(payload)).to be true }
    end

    context 'when the signature comparison is unsuccessful' do
      let(:payload) do
        instance_double(
          Mailgun::Tracking::Payload,
          timestamp: '',
          token: 'b5751a49a024483da8d41c3684f98b8f',
          signature: '374e0b1a3deeb57318c783d43ff71093fbf26406a452761dab91bf346a93b49e'
        )
      end

      it { expect { described_class.verify!(payload) }.to raise_error(Mailgun::Tracking::InvalidSignature) }
    end
  end

  describe '#valid?' do
    context 'when the signature comparison is successful' do
      let(:payload) do
        instance_double(
          Mailgun::Tracking::Payload,
          timestamp: '1499697910',
          token: 'b5751a49a024483da8d41c3684f98b8f',
          signature: '374e0b1a3deeb57318c783d43ff71093fbf26406a452761dab91bf346a93b49e'
        )
      end

      it { is_expected.to be_valid }
    end

    context 'when the signature comparison is unsuccessful' do
      let(:payload) do
        instance_double(
          Mailgun::Tracking::Payload,
          timestamp: '',
          token: 'b5751a49a024483da8d41c3684f98b8f',
          signature: '374e0b1a3deeb57318c783d43ff71093fbf26406a452761dab91bf346a93b49e'
        )
      end

      it { is_expected.not_to be_valid }
    end
  end
end
