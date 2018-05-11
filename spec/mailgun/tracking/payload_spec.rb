require 'spec_helper'

RSpec.describe Mailgun::Tracking::Payload do
  subject(:payload) { described_class.new(options) }

  describe '#[]' do
    let(:options) do
      {
        'Message-Id' => '<payload@mailgun-tracking.com>'
      }
    end

    it 'returns the value object from original payload' do
      expect(payload['Message-Id']).to eq(options['Message-Id'])
    end
  end

  describe '#respond_to?' do
    let(:options) do
      {
        'Message-Id' => '<payload@mailgun-tracking.com>'
      }
    end

    it { is_expected.to respond_to(:message_id) }
    it { expect(payload.message_id).to eq(options['Message-Id']) }
  end

  context 'when the options include a boolean data type' do
    let(:options) do
      {
        boolean: true,
        string: 'string'
      }
    end

    it { is_expected.to be_boolean }
    it { is_expected.to respond_to(:boolean?) }
  end
end
