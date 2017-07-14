require 'spec_helper'

RSpec.describe Mailgun::Tracking::Notifier do
  subject(:notifier) { described_class.new }

  describe '#subscribe' do
    it 'subscribes on event'
  end

  describe '#all' do
    it 'subscribes on all events'
  end

  describe '#broadcast' do
    it 'verify signature'
    it 'broadcasts an event'
  end
end
