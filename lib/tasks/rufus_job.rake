
task :rufus_job => [:environment] do
    scheduler = Rufus::Scheduler.new

    scheduler.every '3s' do
      puts 'Hello... Rufus'
    end

    scheduler.join
end