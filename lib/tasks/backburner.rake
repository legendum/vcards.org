namespace :backburner do

  namespace :work do
    desc "Work the mail queue"
    task :mail => :environment do
      Backburner.work ['mail']
    end

    desc "Work the fast queue"
    task :fast => :environment do
      Backburner.work ['fast']
    end

    desc "Work the slow queue"
    task :slow => :environment do
      Backburner.work ['slow']
    end
  end

  desc "Show job stats"
  task(:stats => :environment) do
    prefix = Backburner.configuration.tube_namespace
    [:mail, :fast, :slow].each do |tube|
      tubename = "#{prefix}.#{tube}"
      begin
        stats = Backburner::Worker.connection.tubes[tubename].stats
        puts <<-End_of_stats
tube #{tubename}:
  ready: #{stats.current_jobs_ready}
  buried: #{stats.current_jobs_buried}
  delayed: #{stats.current_jobs_delayed}
        End_of_stats
      rescue Beaneater::NotFoundError
        puts "WARNING: tube #{tubename} not found!?"
      end
    end
  end

end
