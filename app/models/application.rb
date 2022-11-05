class Application < ApplicationRecord
    has_many :chats, dependent: :destroy
    validates_uniqueness_of :name
    
end
