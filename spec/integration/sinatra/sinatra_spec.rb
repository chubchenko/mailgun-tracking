require 'spec_helper'
require_relative 'dummy'

RSpec.describe 'Sinatra', type: :integration do
  let(:app) { Dummy }
  let(:payload) { fixture('delivered.json') }
  let(:delivered) { instance_double(Delivered) }

  before do
    Mailgun::Tracking.notifier.subscribe :delivered do |payload|
      Delivered.new.call(payload)
    end

    Mailgun::Tracking.notifier.subscribe :bounced do |payload|
      Delivered.new.call(payload)
    end

    allow(delivered).to receive(:call)
    allow(Delivered).to receive(:new).and_return(delivered)

    post('/mailgun', payload)
  end

  it { expect(delivered).to have_received(:call).with(payload).once }
end
