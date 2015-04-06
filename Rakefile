task(:environment) do
  require_relative "./lib/vcards"
  VCards.setup
end

Dir["lib/tasks/*.rake"].each do |task|
  import task
end

# NOTE: Set "RACK_ENV=test" to setup the test database (same for production)
namespace :db do
  desc "Migrate the database"
  task(:migrate => :environment) do
    ActiveRecord::Base.logger = Logger.new(STDOUT)
    ActiveRecord::Migration.verbose = true
    ActiveRecord::Migrator.migrate("db/migrate")
  end
end
