# frozen_string_literal: true

module Mailgun
  module Tracking
    # Creates the Mailgun Tracking initializer file for Rails apps.
    #
    # @example Invocation from terminal
    #   rails generate mailgun:tracking:install API_KEY ENDPOINT
    class InstallGenerator < Rails::Generators::Base
      source_root File.expand_path('templates', __dir__)

      argument :api_key, required: false
      argument :endpoint, required: false

      # Copies the initialization file.
      def copy_initializer_file
        template('mailgun_tracking.rb.erb', 'config/initializers/mailgun_tracking.rb')
      end
    end
  end
end
