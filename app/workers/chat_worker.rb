class ChatWorker
  include Sidekiq::Worker

  def perform(application_id, application_token, chat_number)
    ActiveRecord::Base.connection_pool.with_connection do
      Chat.create!(
        number: chat_number,
        application_id: application_id,
        application_token: application_token,
      )
    end
  end
end
