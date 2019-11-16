# frozen_string_literal: true

require 'hanami'

Hanami::Environment.class_eval do
  def root
    @root ||= Pathname.new(__dir__)
  end
end

Hanami.configure do
  middleware.use(Mailgun::Tracking::Middleware)
end
