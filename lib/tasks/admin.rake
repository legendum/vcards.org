namespace :admin do

  desc "Setup cron jobs"
  task(:crontab) do
    crontab = File.expand_path("../../../config/crontab.txt", __FILE__)
    system "whenever > #{crontab}"
    puts "Wrote #{crontab}"
  end

  desc "Show the ENV"
  task(:env => :environment) do
    require 'yaml'
    puts ENV.to_h.to_yaml
    puts
    puts "(Remember to restart the God process when changing the environment)"
  end

  desc "Run all the tests"
  task(:test) do
    spec_file = ENV['SPEC_FILE'] # an optional file to test
    system "LOG=off bundle exec rspec -c -f p #{spec_file}"
  end

end
