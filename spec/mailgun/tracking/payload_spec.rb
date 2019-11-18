# frozen_string_literal: true

RSpec.describe Mailgun::Tracking::Payload do
  subject(:payload) { described_class.new(values) }

  describe '#==' do
    let(:values) { { 'foo' => 'bar' } }

    it { is_expected.to eq(described_class.new('foo' => 'bar')) }
    it { is_expected.not_to eq(described_class.new('foo': 'rab')) }
    it { is_expected.not_to eq('foo') }
  end

  describe '#respond_to?' do
    let(:values) { { 'foo' => 'bar', 'boolean': true } }

    it { is_expected.to respond_to(:foo) }
    it { is_expected.to respond_to(:boolean?) }
    it { is_expected.not_to respond_to(:foo?) }
  end

  describe '#[]' do
    let(:values) { { 'Message-Id' => '<payload@mailgun-tracking.com>' } }

    it 'returns the value object from values' do
      expect(payload[:message_id]).to eq('<payload@mailgun-tracking.com>')
    end
  end

  describe '#hash' do
    let(:values) { { 'foo' => 'bar' } }

    it { expect(payload.hash).to eq(described_class.new('foo' => 'bar').hash) }
    it { expect(payload.hash).not_to eq(described_class.new('foo': 'rab').hash) }
    it { expect(payload.hash).not_to eq('foo'.hash) }
  end

  describe '#to_hash' do
    let(:values) do
      {
        'foo' => 'bar',
        'list' => [described_class.new('foo' => 'bar')],
        'bar' => { 'foo' => 'bar', 'bar' => described_class.new('foo' => 'bar') }
      }
    end

    it 'recursively call to_hash on its values' do
      expect(payload.to_hash).to eql(
        foo: 'bar',
        list: [{ foo: 'bar' }],
        bar: { foo: 'bar', bar: { foo: 'bar' } }
      )
    end
  end

  describe '#to_s' do
    let(:values) do
      {
        'foo' => 'bar',
        'list' => [described_class.new('foo' => 'bar')],
        'bar' => { 'foo' => 'bar', 'bar' => described_class.new('foo' => 'bar') }
      }
    end

    it 'will call to_s for all embedded stripe objects' do
      expect(payload.to_s).to eql(JSON.pretty_generate(
                                    foo: 'bar',
                                    list: [{ foo: 'bar' }],
                                    bar: { foo: 'bar', bar: { foo: 'bar' } }
                                  ))
    end
  end
end
