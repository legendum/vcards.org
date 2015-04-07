#ruby-gemset=vcards
source "https://rubygems.org"

ruby "2.2.0"

# Sinatra web server
gem "sinatra"
gem "sinatra-partial", require: "sinatra/partial"
gem "sinatra-assetpack", require: "sinatra/assetpack"
gem "sinatra-activerecord"
gem "sinatra-flash"
gem "unicorn"

# API
gem "grape"
gem "grape-entity"

# Asset compilation
gem "sass"
gem "uglifier"

# Config
gem "dotenv"

# Data management
gem "activerecord"
gem "activerecord-mysql-adapter"
gem "activesupport", require: "active_support/all"
gem "geoip" # to locate IP addresses
gem "mysql2"
gem "yajl-ruby", require: "yajl"

# Email
gem "mail"
gem "mailgun"
gem "roadie"

# Message queue
gem "backburner"

# Operations
gem "beanstalkd_view"
gem "foreman"
gem "rake"
gem "whenever"

# Integrations
gem "omniauth"

# Privacy
gem "sshkey"

group :development do
  gem "mailcatcher", require: false
  gem "pry"
  gem "pry-byebug"
end

group :test do
  gem "rspec"
  gem "rack-test"
  gem "factory_girl"
  gem "database_cleaner"
end

group :production do
  gem "foreman_god", git: "git://github.com/legendum/foreman_god.git"
  gem "god"
end
