# frozen_string_literal: true

module RackHelpers
  def env_for(url, options = {})
    Rack::MockRequest.env_for(url, options)
  end
end
