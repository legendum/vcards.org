require "rspec"
require "rack/test"
require "factory_girl"
require "database_cleaner"

ENV["RACK_ENV"] = "test"

require File.expand_path "../../lib/vcards.rb", __FILE__
VCards.setup

# Setup test email
Mail.defaults do
  delivery_method :test
end

# Setup test mocks
Dir["spec/mocks/**/*.rb"].each do |file|
  require_relative "../#{file}"
end

# Setup test factories
Dir["spec/factories/**/*.rb"].each do |file|
  require_relative "../#{file}"
end

# Setup test database and its logging
DatabaseCleaner.strategy = :truncation
ActiveRecord::Base.logger = nil if ENV['LOG'] == 'off' # in lib/tasks/admin.rake

# Setup RSpec methods
module RSpecMixin
  include Rack::Test::Methods
  include Mail::Matchers
end

RSpec.configure do |config|
  config.include RSpecMixin
  config.include FactoryGirl::Syntax::Methods
  config.before(:suite) do
    begin
      DatabaseCleaner.start
      FactoryGirl.lint
    ensure
      DatabaseCleaner.clean
    end
  end
end
