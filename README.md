# Mailgun Tracking

[![Gem Version Badge](https://badge.fury.io/rb/mailgun-tracking.svg)](https://badge.fury.io/rb/mailgun-tracking)
[![CircleCI Badge](https://circleci.com/gh/chubchenko/mailgun-tracking.svg?style=shield)](https://circleci.com/gh/chubchenko/mailgun-tracking)
[![Gem Downloads Badge](https://img.shields.io/gem/dt/mailgun-tracking)](https://rubygems.org/gems/mailgun-tracking)
[![Code Climate Badge](https://codeclimate.com/github/chubchenko/mailgun-tracking/badges/gpa.svg)](https://codeclimate.com/github/chubchenko/mailgun-tracking)
[![Test Coverage Badge](https://codeclimate.com/github/chubchenko/mailgun-tracking/badges/coverage.svg)](https://codeclimate.com/github/chubchenko/mailgun-tracking/coverage)
[![Inline Docs Badge](http://inch-ci.org/github/chubchenko/mailgun-tracking.svg)](http://inch-ci.org/github/chubchenko/mailgun-tracking)

This gem provides a simple way for integration with Mailgun Webhooks.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'mailgun-tracking'
```

And then execute:

```bash
bundle
```

Or install it yourself as:

```bash
gem install mailgun-tracking
```

## Configurations

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
  config.on 'delivered' do |payload|
    # Do something with the incoming data.
  end

  config.all do |payload|
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
  config.on 'bounced', Bounced.new(Rails.logger)
end
```

### Sinatra

To use Mailgun Tracking with Sinatra, simply `require` the gem, configure it and `use` our Rack middleware.

```ruby
require 'sinatra/base'
require 'mailgun/tracking'

Mailgun::Tracking.configure do |config|
  config.api_key = 'key-qblubkqnkdn4lfes5oscf57ryllaia42'
  config.endpoint = '/mailgun'

  config.on 'bounced', Bounced.new

  config.all do |payload|
    # Handle all event types.
  end
end

class Application < Sinatra::Base
  use Mailgun::Tracking::Middleware
end

run Application.run!
```

## Testing

Handling webhooks is a critical piece of modern systems. Verifying the behavior of `Mailgun::Tracking` subscribers
can be done fairly easily by stubbing out the HTTP signature header used to authenticate the webhook request.
[RequestBin](https://requestbin.com/) is great for collecting the payloads. For exploratory phases of development,
[UltraHook](http://www.ultrahook.com/) and other tools can forward webhook requests directly to the localhost.
Here an example of how to test `Mailgun::Tracking` with RSpec request specs:

```ruby
RSpec.describe 'Mailgun Webhooks' do
  describe 'delivered' do
    let(:payload) { File.read('spec/support/fixtures/delivered.json') }
    let(:bounced) { instance_double(Bounced) }

    before do
      allow(bounced).to receive(:call)
      allow(Bounced).to receive(:new).and_return(bounced)
    end

    it 'is successful' do
      post('/mailgun', body: payload)

      expect(bounced).to have_received(:call).with(payloads)
    end
  end
end
```

## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).
