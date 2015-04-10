namespace :god do

  desc "Restart God"
  task(:restart => :environment) do
    system "god -c ./foreman.god"
    system "god restart"
  end

end
