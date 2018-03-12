RSpec.shared_examples :acts_as_rack do
  class Delivered
    def call(payload); end
  end

  let(:app) { Dummy::Application }
  let(:payload) { fixture('delivered.json') }
  let(:delivered) { instance_double(Delivered) }

  before do
    allow(delivered).to receive(:call)
    allow(Delivered).to receive(:new).and_return(delivered)

    Mailgun::Tracking.notifier.subscribe(:delivered, Delivered.new)

    Mailgun::Tracking.notifier.subscribe :bounced do |payload|
      Delivered.new.call(payload)
    end

    Mailgun::Tracking.notifier.all do |payload|
      Delivered.new.call(payload)
    end

    post('/mailgun', payload)
  end

  it { expect(delivered).to have_received(:call).with(payload).twice }
end
