require 'dummy/sinatra/application'

RSpec.describe 'Sinatra', type: :integration do
  it_behaves_like 'acts as rack'
end
