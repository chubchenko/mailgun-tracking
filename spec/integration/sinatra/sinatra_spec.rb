require 'spec_helper'
require 'integration/sinatra/dummy'


RSpec.describe 'Sinatra' do
  let!(:app) { Dummy }

  let(:body) do
    fixture('delivered.json')
  end

  it 'test' do
    post '/mailgun', body
  end
end
