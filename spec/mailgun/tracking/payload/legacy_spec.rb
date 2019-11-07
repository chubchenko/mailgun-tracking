# frozen_string_literal: true

RSpec.describe Mailgun::Tracking::Payload::Legacy do
  subject(:legacy) { described_class.new(options) }

  let(:options) { fixture('legacy/delivered.json') }

  describe '#body' do
    it 'returns body' do
      expect(legacy.body).to eq(options)
    end
  end

  describe '#event' do
    it 'returns event' do
      expect(legacy.event).to eq(options.fetch('event'))
    end
  end

  describe '#token' do
    it 'returns token' do
      expect(legacy.token).to eq(options.fetch('token'))
    end
  end

  describe '#timestamp' do
    it 'returns timestamp' do
      expect(legacy.timestamp).to eq(options.fetch('timestamp'))
    end
  end

  describe '#signature' do
    it 'returns signature' do
      expect(legacy.signature).to eq(options.fetch('signature'))
    end
  end
end
