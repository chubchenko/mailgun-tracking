# frozen_string_literal: true

module Mailgun
  module Tracking
    # A general Mailgun Tracking exception.
    Error = Class.new(StandardError)

    # Raised when signature is invalid.
    InvalidSignature = Class.new(Error)
  end
end
