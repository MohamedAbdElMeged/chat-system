require "sneakers/tasks"
namespace :rabbitmq do 
    task :setup do 
        conn = Bunny.new(:host => ENV['RABBITMQ_HOST'])
        conn.start
        ch = conn.create_channel
        queue = ch.queue("instabugConsumer.chats",durable: true)
        queue.bind("instabug.chats") 
        queue2 = ch.queue("instabugConsumer.messages",durable: true)
        queue2.bind("instabug.messages") 
        conn.close
    end
end
