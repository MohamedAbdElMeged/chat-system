task rufus_job: [:environment] do
  scheduler = Rufus::Scheduler.new

  scheduler.every '1m' do
    ActiveRecord::Base.connection_pool.with_connection do
      Application.find_each do |app|
        app.update_column(:chats_count, app.chats.size)
      end
      Chat.find_each do |chat|
        chat.update_column(:messages_count, chat.messages.size)
      end
    end
  end

  scheduler.join
end
