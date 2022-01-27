class MessageWorker
    include Sneakers::Worker
        
    from_queue "messages", env: nil

    def work(raw_message)
        raw_message= JSON.parse(raw_message)
        message = Message.new
        message.number = raw_message['number']
        message.body = raw_message['body']
        message.chat = Chat.find(raw_message['chat_id'])
        message.save!
        ack!
    end
    
end