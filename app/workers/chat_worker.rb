class ChatWorker
    include Sneakers::Worker
        
    from_queue "chats", env: nil

    def work(raw_chat)
        ActiveRecord::Base.connection_pool.with_connection do
            raw_chat= JSON.parse(raw_chat)
            chat = Chat.new
            chat.number = raw_chat['number']
            chat.application= Application.find(raw_chat['application_id'])
            chat.application_token = chat.application.token
            chat.save!
            puts chat.inspect
        end
        ack!
    end
end