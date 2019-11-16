# CHANGELOG

## Unreleased

* Added
  * Test with Hanami 1.X, head 🌸

## 1.1.0 (2019-11-15)

* Added
  * Add integration with new webhooks API
* Changed
  * `Mailgun::Tracking::Payload::Legacy` is deprecated in favor of `Mailgun::Tracking::Payload`

## 1.0.0 (2019-10-16)

* Added
  * Add `frozen_string_literal` pragma comment to all Ruby files
  * Test with Ruby 2.6
  * Dup middleware to avoid race conditions

* Changed
  * Automatically require spec_helper in all specs
  * Replace `codeclimate-test-reporter` by new `test-reporter`
  * Migrate from CircleCI 2.0 to 2.1
  * Migrate to CodeClimate 2.0

## 0.3.0 (2018-05-11)

* Added
  * Test with Sinatra
  * Test with Rack
  * Test with Rails 4.2, 5.0, 5.1, 5.2
  * Respond with `Bad request` if a signature is invalid
  * Pass `Mailgun::Tracking::Payload` object to each subscribed

* Changed
  * Migrate from Travis CI to Circle CI

## 0.2.4 (2018-03-07)

* Changed
  * Update RuboCop version and fix all issues
  * Create a `Mailgun::Tracking::Version` module to hold information about the version

* Removed
  * Remove the method `configure` and delegate missing methods to configuration

## 0.2.2 (2017-09-01)

* Added
  * Introduce `Mailgun::Tracking::Configuration` to store information about configuration

## 0.2.1 (2017-07-23)

* Added
  * Add Rails generator
    Adds `rails generate mailgun:tracking:install API_KEY ENDPOINT` Rails generator

* Changed
  * Improve documentation about configuration and usage

## 0.2.0 (2017-07-16)

* Added
  * Add the ability to subscribe to all events
  * Create a `Mailgun::Tracking::Railtie` to use `Mailgun::Tracking::Middleware`
  * Wrap each callable object into `Mailgun::Tracking::Subscriber::Evented` or `Mailgun::Tracking::Subscriber::AllMessages`

* Changed
  * Move `subscribe` and `broadcast` to into `Mailgun::Tracking::Notifier`
