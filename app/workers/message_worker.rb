class MessageWorker
  include Sidekiq::Worker

  def perform(application_token, chat_id, chat_number, message_number, body)
    ActiveRecord::Base.connection_pool.with_connection do
      Message.create!(
        number: message_number,
        chat_id: chat_id,
        chat_number: chat_number,
        body: body,
        application_token: application_token,
      )
    end
  end
end
