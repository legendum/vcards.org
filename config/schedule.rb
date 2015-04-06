# Learn more: http://github.com/javan/whenever

set :output, File.expand_path("../../log/cron.log", __FILE__)
set :environment_variable, "RACK_ENV"

every 10.minutes do
  rake "facts:test"
end

every 1.hour do
  rake "facts:create"
end
