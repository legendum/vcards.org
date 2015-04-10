require_relative "./lib/vcards.rb"
VCards.setup

ENV["RACK_ENV"] ||= "development"
ENV["BEANSTALK_URL"] ||= "beanstalk://localhost/"
ENV["AUTH_PASSWORD"] ||= "password" # NOTE: override this in your .env file

map "/" do
  run VCards::App
end

map "/api" do
  use Rack::Session::Cookie, secret: ENV["SESSION_SECRET"]
  run Rack::Cascade.new([
    VCards::APIv1::Version.class_list,
    VCards::APIv2::Version.class_list,
  ].flatten)
end

require "beanstalkd_view"
{
  admin: VCards::Admin,
  beanstalk: BeanstalkdView::Server,
}.each do |path, server_class|
  app = Rack::Auth::Digest::MD5.new(server_class) do |username|
    {"admin" => ENV["AUTH_PASSWORD"]}[username]
  end
  app.realm = "Protected Area"
  app.opaque = ENV["AUTH_PASSWORD"]
  map "/#{path}" do
    run app
  end
end
