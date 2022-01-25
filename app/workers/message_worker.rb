class MessageWorker
    include Sneakers::Worker
        
    from_queue "sneakers.messages", env: nil

    def work(raw_message)
        puts raw_message.to_s

        ack!
    end
    
end