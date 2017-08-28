require 'spec_helper'

RSpec.describe Mailgun::Tracking do
  describe '.configure' do
    let(:configuration) { instance_double(Mailgun::Tracking::Configuration) }
    let(:options) do
      {
        api_key: 'key-qblubkqnkdn4lfes5oscf57ryllaia42',
        endpoint: '/mailgun-tracking'
      }
    end

    before do
      allow(configuration).to receive(:configure)
      allow(Mailgun::Tracking::Configuration).to receive(:instance) { configuration }
    end

    it do
      described_class.configure(options)
      expect(configuration).to have_received(:configure).with(options)
    end

    it 'setup block yields Mailgun::Tracking::Configuration' do
      described_class.configure do |config|
        expect(config).to eq(Mailgun::Tracking::Configuration.instance)
      end
    end
  end

  describe '.notifier' do
    it 'returns an instance of Mailgun::Tracking::Notifier' do
      expect(described_class.notifier).to be_instance_of(Mailgun::Tracking::Notifier)
    end
  end
end
