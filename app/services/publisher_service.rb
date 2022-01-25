class PublisherService
    # In order to publish message we need a exchange name.
    # Note that RabbitMQ does not care about the payload -
    # we will be using JSON-encoded strings
    def self.publish(exchange, message = {})
        @connection ||= $bunny.tap do |c|
            c.start
        end
        @channel = @connection.create_channel
        @fanout = @channel.fanout("instabug.#{exchange}")
        @fanout.publish(message.to_json)
    end
    def self.publish2(exchange, message = {})
        @connection ||= $bunny.tap do |c|
            c.start
        end
        @channel = @connection.create_channel
        @queue = @channel.queue(exchange)
        @channel.default_exchange.publish(message.to_s, routing_key: @queue.name)
    end



    


end