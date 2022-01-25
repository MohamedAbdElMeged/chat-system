class Application < ApplicationRecord
    has_many :chats, dependent: :destroy
    before_create :generate_application_token , on: :create
    
    def generate_application_token
        self.token = GenerateApplicationTokenHelper.new.create_token()
    end
end
