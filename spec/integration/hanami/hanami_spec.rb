# frozen_string_literal: true

if defined?(::Hanami)
  require 'dummy/hanami/application'

  RSpec.describe 'Hanami', type: :integration do
    it_behaves_like 'acts as rack' do
      let(:app) { Hanami.app }
    end
  end
end
