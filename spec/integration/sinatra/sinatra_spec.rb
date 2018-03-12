require 'spec_helper'
require 'dummy/sinatra/application'

RSpec.describe 'Sinatra', type: :integration do
  it_behaves_like :acts_as_rack
end
