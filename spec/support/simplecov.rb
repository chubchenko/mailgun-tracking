if ENV['COVERAGE'] == 'true'
  require 'simplecov'

  SimpleCov.start do
    add_filter('integration')
  end
end
