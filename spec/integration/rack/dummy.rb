Dummy = Rack::Builder.new do
  use Mailgun::Tracking::Middleware

  map '/' do
    run(
      proc do |_env|
        [200, { 'Content-Type' => 'text/plain' }, ['^_^']]
      end
    )
  end
end

class Delivered
  def call(payload); end
end
