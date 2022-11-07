class Application < ApplicationRecord
  has_many :chats, dependent: :destroy
  validates :name, presence: true, uniqueness: true
  validates :token, presence: true, uniqueness: true
end
