# NOTE: Set "RACK_ENV=test" to setup the test database (same for production)
namespace :db do

  def db_config
    @db_config ||= ActiveRecord::Base.connection_config
  end

  desc "Migrate the database"
  task(:migrate => :environment) do
    ActiveRecord::Base.logger = Logger.new(STDOUT)
    ActiveRecord::Migration.verbose = true
    ActiveRecord::Migrator.migrate("db/migrate")
  end

  desc "Create the database"
  task(:create => :environment) do
    ActiveRecord::Base.logger = Logger.new(STDOUT)
    ActiveRecord::Base.establish_connection(db_config.except(:database))
    ActiveRecord::Base.connection.create_database db_config[:database]
  end

  desc "Drop the database"
  task(:drop => :environment) do
    ActiveRecord::Base.logger = Logger.new(STDOUT)
    ActiveRecord::Base.connection.drop_database db_config[:database]
  end

end
