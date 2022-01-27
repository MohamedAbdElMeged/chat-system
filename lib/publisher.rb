class Publisher

    def self.publish(queue, message = {})
        @connection ||= $bunny.tap do |c|
            c.start
        end
        @channel = @connection.create_channel
        queuex = @channel.queue(queue,durable:true)
        queuex.publish(message.to_json, routing_key: queuex.name)
    end
end