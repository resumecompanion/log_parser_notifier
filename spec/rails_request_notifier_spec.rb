require 'spec_helper'

require './spec/support/rails_log_requests'

module LogParserNotifier
  describe RailsRequestNotifier do
    let :rails_request_notifier do
      RailsRequestNotifier.new(@logs)
    end

    it 'should test' do
      @logs = RailsLogRequests.normal_request_1

      expect_any_instance_of(Statsd).to receive(:increment).with('rails.requests', tags: %w(controller:DashboardController action:show con_act:DashboardController#show))
      expect_any_instance_of(Statsd).to receive(:timing).with('rails.load_time', 91, tags: %w(controller:DashboardController action:show con_act:DashboardController#show))

      rails_request_notifier.parse_and_trigger_notifications
    end
  end
end
