require 'sinatra/base'

module Dummy
  class Application < Sinatra::Base
    use Mailgun::Tracking::Middleware
  end
end
