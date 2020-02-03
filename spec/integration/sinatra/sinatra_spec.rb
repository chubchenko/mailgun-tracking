# frozen_string_literal: true

if defined?(::Sinatra)
  require 'dummy/sinatra/application'

  RSpec.describe 'Sinatra', type: :integration do
    it_behaves_like 'acts as rack'
  end
end
