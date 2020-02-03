# frozen_string_literal: true

RSpec.shared_examples 'acts as rack' do
  let(:app) { Dummy::Application }
  let(:payload) { fixture('delivered.json') }

  class Delivered
    def self.call(payload); end
  end

  before do
    allow(Delivered).to receive(:call)

    Mailgun::Tracking.on(:delivered, Delivered)

    Mailgun::Tracking.on(:bounced) do |payload|
      Delivered.call(payload)
    end

    Mailgun::Tracking.all(Delivered)
  end

  it do
    post('/mailgun', payload.to_json, 'CONTENT_TYPE' => 'application/json')
    expect(Delivered).to have_received(:call).with(
      payload
    ).twice
  end

  context 'when the signature comparison is unsuccessful' do
    before { payload['signature']['timestamp'] = '' }

    it do
      post('/mailgun', payload.to_json, 'CONTENT_TYPE' => 'application/json')
      expect(last_response).to be_bad_request
    end
  end
end
