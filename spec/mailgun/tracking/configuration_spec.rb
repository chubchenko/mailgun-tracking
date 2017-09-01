require 'spec_helper'

RSpec.describe Mailgun::Tracking::Configuration do
  subject(:configuration) { described_class.instance }

  it 'always refers to the same instance' do
    expect(configuration).to eql(described_class.instance)
  end

  describe '#configure' do
    let(:options) do
      {
        api_key: 'key-csyaunqpfvy6buznrm9ddyu4y7jakuc6',
        endpoint: '/new-mailgun-tracking'
      }
    end

    let(:ensure_configuration_via_options) do
      configuration.configure(options)
    end

    let(:ensure_configuration_via_block) do
      configuration.configure do |config|
        config.api_key = options[:api_key]
        config.endpoint = options[:endpoint]
      end
    end

    def ensure_expect_to_change_state
      expect { yield }.to change(configuration, :api_key)
        .to(options[:api_key]).and change(configuration, :endpoint).to(options[:endpoint])
    end

    it { ensure_expect_to_change_state { ensure_configuration_via_options } }
    it { ensure_expect_to_change_state { ensure_configuration_via_block } }
  end
end
