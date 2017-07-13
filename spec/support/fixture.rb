require 'json'

class FixtureFinder
  FIXTURE_PATH = File.expand_path('../fixtures', __dir__)

  def initialize(file)
    @file = file
  end

  def find
    File.read(FIXTURE_PATH + '/' + @file)
  end
end

def fixture(file)
  JSON.parse(FixtureFinder.new(file).find)
end
