require 'dummy/rack/application'

RSpec.describe 'Rack', type: :integration do
  it_behaves_like 'acts as rack'
end
