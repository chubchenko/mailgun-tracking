# frozen_string_literal: true

RSpec.describe Mailgun::Tracking::Request do
  subject(:request) { described_class.new(env) }

  describe '#mailgun_tracking?' do
    context 'when a request to a endpoint with a POST method' do
      let(:env) { env_for('http://localhost:3000/mailgun', method: :post) }

      it { is_expected.to be_mailgun_tracking }
    end

    context 'when a request to a endpoint with a POST method' do
      let(:env) { env_for('http://localhost:3000/mailgun', method: :get) }

      it { is_expected.not_to be_mailgun_tracking }
    end

    context 'when the request is not to the endpoint' do
      let(:env) { env_for('http://localhost:3000') }

      it { is_expected.not_to be_mailgun_tracking }
    end
  end

  describe '#payload' do
    context 'when the parameters contain the timestamp' do
      let(:env) { env_for('http://localhost:3000/mailgun', method: :post, params: { 'timestamp' => '1572632560' }) }

      it 'returns legacy payload' do
        expect(request.payload).to be_an_instance_of(Mailgun::Tracking::Payload::Legacy)
      end
    end

    context 'when the parameters do not contain the timestamp' do
      let(:env) { env_for('http://localhost:3000/mailgun', method: :post, params: { 'signature' => {} }) }

      it 'returns payload' do
        expect(request.payload).to be_an_instance_of(Mailgun::Tracking::Payload)
      end
    end
  end

  context 'when application/json request' do
    let(:env) { env_for('/', method: :post, input: input, 'CONTENT_TYPE' => content_type) }
    let(:input) { 'foo=bar' }
    let(:content_type) { 'application/json; charset=utf-8' }

    it 'rewinds input' do
      expect(request.body.read).to eq(input)
    end

    context 'when input is a hash' do
      let(:input) { '{"qux": "bin"}' }

      it 'adds a parsed hash to POST params' do
        expect(request.params['qux']).to eq('bin')
      end
    end
  end
end
