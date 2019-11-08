# frozen_string_literal: true

RSpec.describe Mailgun::Tracking::Middleware do
  subject(:rack) { described_class.new(app) }

  let(:app) { proc { [200, {}, []] } }
  let(:notifier) { instance_double(Mailgun::Tracking::Notifier) }
  let(:request) do
    instance_double(Mailgun::Tracking::Request, payload: payload, media_type: 'application/x-www-form-urlencoded')
  end
  let(:env) { env_for('http://localhost:3000') }
  let(:payload) { instance_double(Mailgun::Tracking::Payload::Legacy, event: 'delivered') }

  before do
    allow(Mailgun::Tracking).to receive(:notifier).and_return(notifier)
    allow(Mailgun::Tracking::Request).to receive(:new).with(env).and_return(request)
  end

  describe '#call' do
    context 'when request is not respond to the specified URL' do
      before do
        allow(request).to receive(:mailgun_tracking?).and_return(false)
        allow(notifier).to receive(:broadcast)
      end

      it { expect(rack.call(env)).to include(200) }

      it do
        rack.call(env)
        expect(Mailgun::Tracking).not_to have_received(:notifier)
      end
    end

    context 'when request is respond to the specified URL and the signature comparison is unsuccessful' do
      let(:params) { fixture('legacy/delivered.json') }

      before do
        allow(notifier).to receive(:broadcast).and_raise(Mailgun::Tracking::InvalidSignature)
        allow(request).to receive(:mailgun_tracking?).and_return(true)
        allow(request).to receive(:params).and_return(params)
      end

      it { expect(rack.call(env)).to include(400) }

      it do
        rack.call(env)
        expect(Mailgun::Tracking).to have_received(:notifier)
      end
    end

    context 'when request is respond to the specified URL and the signature comparison is successful' do
      let(:params) { fixture('legacy/delivered.json') }

      before do
        allow(request).to receive(:mailgun_tracking?).and_return(true)
        allow(request).to receive(:params).and_return(params)
        allow(notifier).to receive(:broadcast)
      end

      it { expect(rack.call(env)).to include(200) }

      it do
        rack.call(env)
        expect(Mailgun::Tracking).to have_received(:notifier)
      end
    end
  end
end
