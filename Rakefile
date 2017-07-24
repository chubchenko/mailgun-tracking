require 'bundler/gem_tasks'
require 'rspec/core/rake_task'

desc 'Build Gem'
task :build do
  system 'gem build mailgun-tracking.gemspec'
end

desc 'Console'
task :console do
  sh 'pry --gem'
end

RSpec::Core::RakeTask.new(:spec)

task default: :spec
