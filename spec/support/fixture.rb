# frozen_string_literal: true

require 'json'

class FixtureFinder
  def initialize(file)
    @file = file
    @fixture_path = File.expand_path('../fixtures', dir)
  end

  def find
    File.read(@fixture_path + '/' + @file)
  end

  private

  def dir
    File.dirname(__FILE__)
  end
end

def fixture(file)
  JSON.parse(FixtureFinder.new(file).find)
end
