class ChatWorker
    include Sneakers::Worker
        
    from_queue "chats", env: nil

    def work(raw_chat)
        ActiveRecord::Base.connection_pool.with_connection do
            raw_chat= JSON.parse(raw_chat)
            application = Application.find(raw_chat['application_id'])
            chat = Chat.new
            chat.number = raw_chat['number']
            chat.application= application
            chat.application_token = application.token
            chat.save!
        end
        ack!
    end
end