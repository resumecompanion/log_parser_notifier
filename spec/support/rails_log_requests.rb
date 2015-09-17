module LogParserNotifier
  module RailsLogRequests
    def self.normal_request_1
StringIO.new %Q(I, [2015-08-24T07:36:43.598000 #19020]  INFO -- : Started GET "/dashboard" for 50.31.29.217 at 2015-08-24 07:36:43 +0000
I, [2015-08-24T07:36:43.603000 #19020]  INFO -- : Processing by DashboardController#show as HTML
I, [2015-08-24T07:36:43.666000 #19020]  INFO -- :   Rendered dashboard/_documents.html.erb (5.0ms)
I, [2015-08-24T07:36:43.668000 #19020]  INFO -- :   Rendered dashboard/_subscription.html.erb (1.0ms)
I, [2015-08-24T07:36:43.669000 #19020]  INFO -- :   Rendered dashboard/_account.html.erb (2.0ms)
I, [2015-08-24T07:36:43.670000 #19020]  INFO -- :   Rendered dashboard/_billing.html.erb (0.0ms)
I, [2015-08-24T07:36:43.671000 #19020]  INFO -- :   Rendered dashboard/show.html.erb within layouts/application (11.0ms)
I, [2015-08-24T07:36:43.677000 #19020]  INFO -- :   Rendered shared/_gtm.html.erb (0.0ms)
I, [2015-08-24T07:36:43.683000 #19020]  INFO -- :   Rendered layouts/_guest_menu.html.erb (3.0ms)
I, [2015-08-24T07:36:43.684000 #19020]  INFO -- :   Rendered shared/_contact_number.erb (0.0ms)
I, [2015-08-24T07:36:43.687000 #19020]  INFO -- :   Rendered shared/_mega_menu.html.erb (1.0ms)
I, [2015-08-24T07:36:43.688000 #19020]  INFO -- :   Rendered documents/_preview.html.erb (0.0ms)
I, [2015-08-24T07:36:43.692000 #19020]  INFO -- :   Rendered shared/_contact_number.erb (0.0ms)
I, [2015-08-24T07:36:43.694000 #19020]  INFO -- :   Rendered shared/_disclaimer.html.erb (1.0ms)
I, [2015-08-24T07:36:43.695000 #19020]  INFO -- : Completed 200 OK in 91ms (Views: 34.0ms | ActiveRecord: 4.0ms)
)
    end

    def self.failed_request
StringIO.new %Q(I, [2015-08-24T07:35:11.541000 #19020]  INFO -- : Started GET "/documents/9293/preview/?page=0" for 50.31.29.217 at 2015-08-24 07:35:11 +0000
I, [2015-08-24T07:35:11.549000 #19020]  INFO -- : Processing by DocumentsController#preview as JSON
I, [2015-08-24T07:35:11.550000 #19020]  INFO -- :   Parameters: {"page"=>"0", "id"=>"9293"}
I, [2015-08-24T07:35:11.597000 #19020]  INFO -- : Completed 404 Not Found in 46ms
F, [2015-08-24T07:35:11.645000 #19020] FATAL -- :
ActiveRecord::RecordNotFound (Couldn't find Document with 'id'=9293 [WHERE "documents"."user_id" = ?]):
  app/controllers/documents_controller.rb:208:in `set_document'
)
    end

    def self.partial_request
StringIO.new %Q(I, [2015-08-24T07:36:43.598000 #19020]  INFO -- : Started GET "/dashboard" for 50.31.29.217 at 2015-08-24 07:36:43 +0000
I, [2015-08-24T07:36:43.603000 #19020]  INFO -- : Processing by DashboardController#index as HTML
I, [2015-08-24T07:36:43.666000 #19020]  INFO -- :   Rendered dashboard/_documents.html.erb (5.0ms)
I, [2015-08-24T07:36:43.668000 #19020]  INFO -- :   Rendered dashboard/_subscription.html.erb (1.0ms)
I, [2015-08-24T07:36:43.669000 #19020]  INFO -- :   Rendered dashboard/_account.html.erb (2.0ms)
I, [2015-08-24T07:36:43.670000 #19020]  INFO -- :   Rendered dashboard/_billing.html.erb (0.0ms)
I, [2015-08-24T07:36:43.671000 #19020]  INFO -- :   Rendered dashboard/show.html.erb within layouts/application (11.0ms)
I, [2015-08-24T07:36:43.677000 #19020]  INFO -- :   Rendered shared/_gtm.html.erb (0.0ms)
I, [2015-08-24T07:36:43.683000 #19020]  INFO -- :   Rendered layouts/_guest_menu.html.erb (3.0ms)
I, [2015-08-24T07:36:43.598000 #19020]  INFO -- : Started GET "/dashboard" for 50.31.29.217 at 2015-08-24 07:36:43 +0000
I, [2015-08-24T07:36:43.603000 #19020]  INFO -- : Processing by DashboardController#show as HTML
I, [2015-08-24T07:36:43.666000 #19020]  INFO -- :   Rendered dashboard/_documents.html.erb (5.0ms)
I, [2015-08-24T07:36:43.668000 #19020]  INFO -- :   Rendered dashboard/_subscription.html.erb (1.0ms)
I, [2015-08-24T07:36:43.669000 #19020]  INFO -- :   Rendered dashboard/_account.html.erb (2.0ms)
I, [2015-08-24T07:36:43.670000 #19020]  INFO -- :   Rendered dashboard/_billing.html.erb (0.0ms)
I, [2015-08-24T07:36:43.671000 #19020]  INFO -- :   Rendered dashboard/show.html.erb within layouts/application (11.0ms)
I, [2015-08-24T07:36:43.677000 #19020]  INFO -- :   Rendered shared/_gtm.html.erb (0.0ms)
I, [2015-08-24T07:36:43.683000 #19020]  INFO -- :   Rendered layouts/_guest_menu.html.erb (3.0ms)
I, [2015-08-24T07:36:43.684000 #19020]  INFO -- :   Rendered shared/_contact_number.erb (0.0ms)
I, [2015-08-24T07:36:43.687000 #19020]  INFO -- :   Rendered shared/_mega_menu.html.erb (1.0ms)
I, [2015-08-24T07:36:43.688000 #19020]  INFO -- :   Rendered documents/_preview.html.erb (0.0ms)
I, [2015-08-24T07:36:43.692000 #19020]  INFO -- :   Rendered shared/_contact_number.erb (0.0ms)
I, [2015-08-24T07:36:43.694000 #19020]  INFO -- :   Rendered shared/_disclaimer.html.erb (1.0ms)
I, [2015-08-24T07:36:43.695000 #19020]  INFO -- : Completed 200 OK in 91ms (Views: 34.0ms | ActiveRecord: 4.0ms)
)
    end
  end
end
