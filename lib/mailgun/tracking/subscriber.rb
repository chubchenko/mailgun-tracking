require 'mailgun/tracking/subscriber/all_messages'
require 'mailgun/tracking/subscriber/evented'

module Mailgun
  module Tracking
    module Subscriber
      def self.for(name, callable)
        if name
          Evented.new(name, callable)
        else
          AllMessages.new(callable)
        end
      end
    end
  end
end
