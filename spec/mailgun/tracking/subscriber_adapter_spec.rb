require 'spec_helper'

RSpec.describe Mailgun::Tracking::SubscriberAdapter do
  subject(:subscriber_adapter) { described_class.new(callable) }

  describe '.call' do
    it 'returns SubscriberAdapter instance'
  end

  describe '#call' do
    it 'calls the callable'
  end
end
