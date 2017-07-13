# Mailgun Tracking

[![Travis CI Badge](https://travis-ci.org/Chubchenko/mailgun-tracking.svg?branch=master)](https://travis-ci.org/Chubchenko/mailgun-tracking)
[![Code Climate Badge](https://codeclimate.com/github/Chubchenko/mailgun-tracking/badges/gpa.svg)](https://codeclimate.com/github/Chubchenko/mailgun-tracking)
[![Test Coverage Badge](https://codeclimate.com/github/Chubchenko/mailgun-tracking/badges/coverage.svg)](https://codeclimate.com/github/Chubchenko/mailgun-tracking/coverage)

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
Mailgun::Tracking.configure do |config|
  config.api_key = ENV['MAILGUN_API_KEY']
end

Workflow::MailgunTracking.subscribe(:delivered) do |payload|
  # Do something with the incoming data.
end
```

## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).
