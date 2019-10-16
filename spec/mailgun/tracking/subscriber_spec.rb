# frozen_string_literal: true

RSpec.describe Mailgun::Tracking::Subscriber do
  describe '.for' do
    let(:callable) { proc {} }

    it 'returns an instance of Mailgun::Tracking::Subscriber::AllMessages' do
      expect(described_class.for(nil, callable)).to be_instance_of(Mailgun::Tracking::Subscriber::AllMessages)
    end

    it 'returns an instance of Mailgun::Tracking::Subscriber::Evented' do
      expect(described_class.for('delivered', callable)).to be_instance_of(Mailgun::Tracking::Subscriber::Evented)
    end
  end
end
