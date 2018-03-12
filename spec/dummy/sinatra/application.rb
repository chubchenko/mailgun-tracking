require 'sinatra'

module Dummy
  class Application < Sinatra::Base
    use Mailgun::Tracking::Middleware
  end
end
