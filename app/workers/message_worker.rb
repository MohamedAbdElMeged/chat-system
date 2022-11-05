class MessageWorker
  include Sneakers::Worker

  from_queue 'messages', env: nil

  def work(raw_message)
    ActiveRecord::Base.connection_pool.with_connection do
      raw_message = JSON.parse(raw_message)
      chat = Chat.find(raw_message['chat_id'])
      message = Message.new
      message.number = raw_message['number']
      message.body = raw_message['body']
      message.chat = chat
      message.chat_number = chat.number
      message.application_token = chat.application_token
      message.save!
    end
    ack!
  end
end
