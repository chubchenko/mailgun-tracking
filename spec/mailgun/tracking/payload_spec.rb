# frozen_string_literal: true

RSpec.describe Mailgun::Tracking::Payload do
  subject(:payload) { described_class.new(options) }

  let(:options) { fixture('delivered.json') }

  describe '#body' do
    it 'returns body' do
      expect(payload.body).to eq(options)
    end
  end

  describe '#event' do
    it 'returns event' do
      expect(payload.event).to eq(options.fetch('event-data').fetch('event'))
    end
  end

  describe '#token' do
    it 'returns token' do
      expect(payload.token).to eq(options.fetch('signature').fetch('token'))
    end
  end

  describe '#timestamp' do
    it 'returns timestamp' do
      expect(payload.timestamp).to eq(options.fetch('signature').fetch('timestamp'))
    end
  end

  describe '#signature' do
    it 'returns signature' do
      expect(payload.signature).to eq(options.fetch('signature').fetch('signature'))
    end
  end
end
