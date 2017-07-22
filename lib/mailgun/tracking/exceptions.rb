module Mailgun
  module Tracking
    Error = Class.new(StandardError)
    InvalidSignature = Class.new(Error)
  end
end
