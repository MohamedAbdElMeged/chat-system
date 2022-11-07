class MessageWorker
  include Sidekiq::Worker
  sidekiq_options retry: false

  def perform(application_token, chat_id, chat_number, message_number, body)
    ActiveRecord::Base.connection_pool.with_connection do
      message = Message.new
      message.number = message_number
      message.body = body
      message.chat_id = chat_id
      message.chat_number = chat_number
      message.application_token = application_token
      message.save!
    end
  end
end
