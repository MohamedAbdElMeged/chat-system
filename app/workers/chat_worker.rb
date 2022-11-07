class ChatWorker
  include Sidekiq::Worker
  sidekiq_options retry: false
  def perform(application_id, application_token, chat_number)
    ActiveRecord::Base.connection_pool.with_connection do
      chat = Chat.new
      chat.number = chat_number
      chat.application_id = application_id
      chat.application_token = application_token
      chat.save!
    end
  end
end
