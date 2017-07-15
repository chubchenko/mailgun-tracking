require 'spec_helper'

RSpec.describe Mailgun::Tracking do
  describe '.configure' do
    it 'setup block yields self' do
      described_class.configure do |config|
        expect(described_class).to eq(config)
      end
    end
  end

  describe '.notifier' do
    it 'returns Notifier instance' do
      expect(described_class.notifier).to an_instance_of(Mailgun::Tracking::Notifier)
    end
  end
end
