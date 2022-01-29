class Chat < ApplicationRecord
  belongs_to :application
  has_many :messages, dependent: :destroy
end
