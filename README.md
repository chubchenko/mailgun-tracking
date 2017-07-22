# Mailgun Tracking

[![Gem Version Badge](https://badge.fury.io/rb/mailgun-tracking.svg)](https://badge.fury.io/rb/mailgun-tracking)
[![Travis CI Badge](https://travis-ci.org/Chubchenko/mailgun-tracking.svg?branch=master)](https://travis-ci.org/Chubchenko/mailgun-tracking)
[![Dependency Status Badge](https://gemnasium.com/Chubchenko/mailgun-tracking.svg)](https://gemnasium.com/Chubchenko/mailgun-tracking)
[![Code Climate Badge](https://codeclimate.com/github/Chubchenko/mailgun-tracking/badges/gpa.svg)](https://codeclimate.com/github/Chubchenko/mailgun-tracking)
[![Test Coverage Badge](https://codeclimate.com/github/Chubchenko/mailgun-tracking/badges/coverage.svg)](https://codeclimate.com/github/Chubchenko/mailgun-tracking/coverage)
[![Inline Docs Badge](http://inch-ci.org/github/Chubchenko/mailgun-tracking.svg)](http://inch-ci.org/github/Chubchenko/mailgun-tracking)

This gem provides a simple way for integration with Mailgun Webhooks.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'mailgun-tracking'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install mailgun-tracking

## Usage

```ruby
class Delivered
  def call(payload)
    # Do something with the incoming data.
  end
end

Mailgun::Tracking.configure do |config|
  config.api_key = ENV['MAILGUN_API_KEY']
  config.endpoint = 'new-endpoint'

  config.notifier.subscribe :delivered do |payload|
    # Do something with the incoming data.
  end

  config.notifier.subscribe :delivered, Delivered.new

  config.notifier.all do |payload|
    # Handle all event types.
  end
end
```

## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).
