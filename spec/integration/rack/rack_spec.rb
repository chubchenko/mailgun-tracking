require 'spec_helper'
require 'dummy/rack/application'

RSpec.describe 'Rack', type: :integration do
  it_behaves_like :acts_as_rack
end
