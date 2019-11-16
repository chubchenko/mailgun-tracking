# frozen_string_literal: true

class Delivered
  def call(payload); end
end

RSpec.shared_examples 'acts as rack' do
  let(:app) { Dummy::Application }
  let(:payload) { fixture('delivered.json') }
  let(:delivered) { instance_double(Delivered) }

  before do
    allow(delivered).to receive(:call)
    allow(Delivered).to receive(:new).and_return(delivered)

    Mailgun::Tracking.notifier.subscribe(:delivered, Delivered.new)

    Mailgun::Tracking.notifier.subscribe :bounced do |payload|
      Delivered.new.call(payload)
    end

    Mailgun::Tracking.notifier.all(Delivered.new)
  end

  it do
    post('/mailgun', payload.to_json, 'CONTENT_TYPE' => 'application/json')
    expect(delivered).to have_received(:call).with(payload).twice
  end

  context 'when the signature comparison is unsuccessful' do
    before { payload['signature']['timestamp'] = '' }

    it do
      post('/mailgun', payload.to_json, 'CONTENT_TYPE' => 'application/json')
      expect(last_response).to be_bad_request
    end
  end
end
