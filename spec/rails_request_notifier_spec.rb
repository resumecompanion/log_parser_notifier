require 'spec_helper'

require './spec/support/rails_log_requests'

module LogParserNotifier
  describe RailsRequestNotifier do
    let :rails_request_notifier do
      RailsRequestNotifier.new(@logs)
    end

    after { rails_request_notifier.parse_and_trigger_notifications }

    describe 'successful requests' do
      before { @logs = RailsLogRequests.normal_request_1 }

      it 'should record the number of successful requests' do
        expect_any_instance_of(Statsd).to receive(:increment).with('rails.requests', tags: %w(controller:DashboardController action:show con_act:DashboardController#show))
      end

      it 'should record the average load time of the requests' do
        expect_any_instance_of(Statsd).to receive(:timing).with('rails.load_time', 91, tags: %w(controller:DashboardController action:show con_act:DashboardController#show))
      end

      it 'should not record the number of failed requests' do
        expect_any_instance_of(Statsd).to_not receive(:increment).with('rails.failed_requests', anything)
      end
    end

    describe 'failed request' do
      before { @logs = RailsLogRequests.failed_request }

      it 'should record the number of failed requests' do
        expect_any_instance_of(Statsd).to receive(:increment).with('rails.failed_requests', tags: %w(controller:DocumentsController action:preview con_act:DocumentsController#preview))
      end

      it 'should not record successful request' do
        expect_any_instance_of(Statsd).to_not receive(:increment).with('rails.requests', anything)
      end

      it 'should not record load time of request' do
        expect_any_instance_of(Statsd).to_not receive(:timing)
      end
    end

    describe 'partial request (AKA log got read while it was being written)' do
      it 'should not record partial requests' do
        @logs = RailsLogRequests.partial_request
        expect_any_instance_of(Statsd).to_not receive(:increment)
        expect_any_instance_of(Statsd).to_not receive(:timing)
      end
    end
  end
end
