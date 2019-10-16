# frozen_string_literal: true

RSpec.describe Mailgun::Tracking do
  it { is_expected.to respond_to(:api_key) }
  it { is_expected.to respond_to(:endpoint) }
  it { is_expected.to respond_to(:api_key=) }
  it { is_expected.to respond_to(:endpoint=) }

  describe '.configure' do
    before do
      described_class.configure do |config|
        config.api_key = 'dab36017-478a-4373-9378-7070eb5968b5'
        config.endpoint = '/mailgun-tracking'

        config.notifier.all(proc {})
      end
    end

    it 'setups api key' do
      expect(described_class.api_key).to eq('dab36017-478a-4373-9378-7070eb5968b5')
    end

    it 'setups endpoint' do
      expect(described_class.endpoint).to eq('/mailgun-tracking')
    end

    it 'adds subscribers' do
      expect(described_class.notifier).not_to be_empty
    end
  end
end
