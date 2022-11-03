
task :rufus_job => [:environment] do
    scheduler = Rufus::Scheduler.new

    scheduler.every '30m' do
        ActiveRecord::Base.connection_pool.with_connection do
            Application.all.each do |app|
                app.chats_count = app.chats.size
                app.save!
            end
            Chat.all.each do |chat|
                chat.messages_count = chat.messages.size
                chat.save!
            end
        end

    end

    scheduler.join
end