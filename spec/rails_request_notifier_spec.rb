require 'spec_helper'

require './spec/support/rails_log_requests'

module LogParserNotifier
  describe RailsRequestNotifier do
    let :rails_request_notifier do
      RailsRequestNotifier.new(@logs)
    end

    describe 'successful requests' do
      before { @logs = RailsLogRequests.normal_request_1 }
      after { rails_request_notifier.parse_and_trigger_notifications }

      it 'should record the number of successful requests' do
        expect_any_instance_of(Statsd).to receive(:increment).with('rails.requests', tags: %w(controller:DashboardController action:show con_act:DashboardController#show))
      end

      it 'should record the average load time of the requests' do
        expect_any_instance_of(Statsd).to receive(:timing).with('rails.load_time', 91, tags: %w(controller:DashboardController action:show con_act:DashboardController#show))
      end

      it 'should not record the number of failed requests' do
        expect_any_instance_of(Statsd).to_not receive(:increment).with('rails.failed_requests', anything)
      end

      it 'should not create an event for short requests' do
        expect_any_instance_of(Statsd).to_not receive('event')
      end

      describe 'slow requests' do
        before { @logs = RailsLogRequests.slow_request }

        it 'should create an event for the slow requests' do
          expect_any_instance_of(Statsd).to receive('event').with(
            'DocumentsController#new GET slow request 0.8 sec',
            "Started GET \"/documents/new?template_id=30000&state=AK\" for 123.193.169.96 at 2015-09-17 03:19:58 +0800\nProcessing by DocumentsController#new as HTML\nParameters: {:template_id=>\"30000\", :state=>\"AK\"}\n  Rendered documents/_preview.html.erb (0.0ms)\n  Rendered shared/_contact_number.erb (0.0ms)\n  Rendered shared/_disclaimer.html.erb (0.001ms)\nCompleted 200 OK in 800ms (Views: 34.0ms | ActiveRecord: 4.0ms)",
            date_happened: 1442431198,
            aggregation_key: 'slow_request_rails',
            source_type_name: 'rails_log',
            alert_type: 'warning',
            tags: %w(controller:DocumentsController action:new con_act:DocumentsController#new)
          )
        end
      end
    end

    describe 'failed request' do
      before { @logs = RailsLogRequests.failed_request }
      after { rails_request_notifier.parse_and_trigger_notifications }

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
        expect_any_instance_of(Statsd).to_not receive(:increment).with('rails.requests', tags: %w(controller:DashboardController action:index con_act:DashboardController#index))
        expect_any_instance_of(Statsd).to_not receive(:timing).with('rails.load_time', anything, tags: %w(controller:DashboardController action:index con_act:DashboardController#index))

        rails_request_notifier.parse_and_trigger_notifications
      end
    end

    describe '.render_line' do
      subject do
        RailsRequestNotifier.render_line @line_hash
      end
      it 'should render start line' do
        @line_hash = { method: 'GET', path: '/documents/new?template_id=30000&state=AK', ip: '123.193.169.96', timestamp: 20_150_917_031_958, line_type: :started, lineno: 1, source: nil, compound: [] }
        expect(subject).to eq 'Started GET "/documents/new?template_id=30000&state=AK" for 123.193.169.96 at 2015-09-17 03:19:58 +0800'
      end

      it 'should render the process line' do
        @line_hash = { controller: 'DocumentsController', action: 'new', format: 'HTML', line_type: :processing, lineno: 2, source: nil, compound: [] }
        expect(subject).to eq 'Processing by DocumentsController#new as HTML'
      end

      it 'should render the params line' do
        @line_hash = { params: { template_id: '30000', state: 'AK' }, line_type: :parameters, lineno: 3, source: nil, compound: [] }

        expect(subject).to eq 'Parameters: {:template_id=>"30000", :state=>"AK"}'
      end

      it 'should render the render line' do
        @line_hash = { rendered_file: 'documents/_preview.html.erb', partial_duration: 0.0, line_type: :rendered, lineno: 4, source: nil, compound: [:partial_duration] }

        expect(subject).to eq '  Rendered documents/_preview.html.erb (0.0ms)'
      end

      it 'should render the completed line' do
        @line_hash = { status: 200, duration: 0.8, view: 0.034, db: 0.004, line_type: :completed, lineno: 7, source: nil, compound: [] }

        expect(subject).to eq 'Completed 200 OK in 800ms (Views: 34.0ms | ActiveRecord: 4.0ms)'
      end
    end
  end
end
