class Chat < ApplicationRecord
  belongs_to :application
  has_many :messages, dependent: :destroy
  before_save :generate_chat_number, on: :create
  
  def generate_chat_number
    self.number = self.application.chats.count + 1
  end

end
