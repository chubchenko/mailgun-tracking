require 'sinatra'

class Dummy < Sinatra::Base
  use Mailgun::Tracking::Middleware
end

class Delivered
  def call(payload); end
end
