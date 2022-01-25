class ChatWorker
    include Sneakers::Worker
        
    from_queue "sneakers.chats", env: nil

    def work(raw_chat)
        x = Chat.new
        x.number = 987
        x.application= Application.find(3)
        x.save!
        ack!
    end
end