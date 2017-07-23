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

## Configuration

### Rails

To integrate Mailgun Tracking with your Rails application, you need to know
your api key and endpoint. Invoke the following command
and replace `API_KEY` and `ENDPOINT` with your values:

```bash
rails generate mailgun:tracking:install API_KEY ENDPOINT
```

This command will generate the Mailgun Tracking configuration file under
`config/initializers/mailgun_tracking.rb`.

## Usage

### Rails

```ruby
Mailgun::Tracking.configure do |config|
  config.notifier.subscribe :delivered do |payload|
    # Do something with the incoming data.
  end

  config.notifier.all do |payload|
    # Handle all event types.
  end
end
```

Subscriber objects that respond to `#call`

```ruby
class Bounced
  def initialize(logger)
    @logger = logger
  end

  def call(payload)
    @logger.info(payload)
  end
end
```

```ruby
Mailgun::Tracking.configure do |config|
  config.notifier.subscribe :bounced, Bounced.new
end
```

## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).
