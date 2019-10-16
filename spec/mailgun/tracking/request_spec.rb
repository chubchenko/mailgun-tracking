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
end
