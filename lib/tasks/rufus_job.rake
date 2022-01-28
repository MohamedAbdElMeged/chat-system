
task :rufus_job => [:environment] do
    scheduler = Rufus::Scheduler.new

    scheduler.every '3m' do
        ActiveRecord::Base.connection_pool.with_connection do
            Application.all.each do |app|
                app.chats_count = app.chats.count
                app.save!
            end
            Chat.all.each do |chat|
                chat.messages_count = chat.messages.count
                chat.save!
            end
            puts  "done!"
        end

    end

    scheduler.join
end