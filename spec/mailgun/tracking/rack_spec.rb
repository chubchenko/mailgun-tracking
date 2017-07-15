require 'spec_helper'

RSpec.describe Mailgun::Tracking::Rack do
  subject(:rack) { described_class.new(app) }

  describe '#call' do
    let(:app) { proc { [200, {}, []] } }
    let(:payload) { fixture('delivered.json') }
    let(:code) { rack.call(env)[0] }
    let(:notifier) { instance_double(Mailgun::Tracking::Notifier) }

    before do
      allow(notifier).to receive(:broadcast)
      allow(Mailgun::Tracking).to receive(:notifier) { notifier }
    end

    context 'when a request to a endpoint with a POST method' do
      let(:env) { env_for('http://localhost:3000/mailgun', method: :post, params: payload) }

      it { expect(code).to eq(200) }
      it do
        code
        expect(notifier).to have_received(:broadcast).with('delivered', payload)
      end
    end

    context 'when a request to a endpoint with a POST method' do
      let(:env) { env_for('http://localhost:3000/mailgun', method: :get, params: payload) }

      it { expect(code).to eq(200) }
      it do
        code
        expect(Mailgun::Tracking).not_to have_received(:notifier)
      end
    end

    context 'when the request is not to the endpoint' do
      let(:env) { env_for('http://localhost:3000') }
      let(:code) { rack.call(env)[0] }

      it { expect(code).to eq(200) }
      it do
        code
        expect(Mailgun::Tracking).not_to have_received(:notifier)
      end
    end
  end
end
