require 'sinatra'
require 'sinatra/base'

class Dummy < Sinatra::Base
  use Mailgun::Tracking::Middleware
end

Mailgun::Tracking.notifier.all do |payload|
  puts '*' * 100
  puts payload
  puts '*' * 100
end
