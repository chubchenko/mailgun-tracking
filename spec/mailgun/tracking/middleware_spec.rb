# frozen_string_literal: true

RSpec.describe Mailgun::Tracking::Middleware do
  let(:app) do
    lambda do |_env|
      [200, { 'Content-Type' => 'text/plain' }, ['^_^']]
    end
  end
  let(:middleware) { described_class.new(app) }

  context 'when a request is not respond to the specified URL' do
    let(:env) { env_for('http://localhost:3000') }

    it { expect(middleware.call(env)).to eq([200, { 'Content-Type' => 'text/plain' }, ['^_^']]) }
  end

  context 'when a request is done not as an HTTP POST request' do
    let(:env) do
      env_for(
        'http://localhost:3000/mailgun',
        'REQUEST_METHOD' => 'GET',
        'CONTENT_TYPE' => 'application/json',
        input: payload.to_json
      )
    end
    let(:payload) { fixture('delivered.json') }

    it { expect(middleware.call(env)).to eq([200, { 'Content-Type' => 'text/plain' }, ['^_^']]) }
  end

  context 'when request is respond to the specified URL, POST request and the signature comparison is unsuccessful' do
    let(:env) do
      env_for(
        'http://localhost:3000/mailgun',
        'REQUEST_METHOD' => 'POST',
        'CONTENT_TYPE' => 'application/json',
        input: payload.to_json
      )
    end
    let(:payload) { fixture('delivered.json') }

    before { payload['signature']['timestamp'] = '' }

    it { expect(middleware.call(env)).to eq([400, {}, []]) }
  end

  context 'when everything matches (URL, POST, Signature)' do
    let(:env) do
      env_for(
        'http://localhost:3000/mailgun',
        'REQUEST_METHOD' => 'POST',
        'CONTENT_TYPE' => 'application/json',
        input: payload.to_json
      )
    end
    let(:payload) { fixture('delivered.json') }

    it { expect(middleware.call(env)).to eq([200, {}, []]) }
  end
end
