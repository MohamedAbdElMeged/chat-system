class PublisherService
  def self.publish(queue, message = {})
    @connection ||= BUNNY.tap(&:start)
    @channel = @connection.create_channel
    queuex = @channel.queue(queue, durable: true)
    queuex.publish(message.to_json, routing_key: queuex.name)
  end
end
