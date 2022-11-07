require 'rails_helper'

RSpec.describe Chat, type: :model do
  let!(:application) { create :application }
  let!(:chat) { create :chat, application_token: application.token, application: application }
  it 'message count should be 0 and chat number should be 1' do
    byebug
    expect(chat.messages_count).to eq(0)
    expect(chat.number).to eq(1)
  end
  #   it { should validate_presence_of(:name) }
  #   it { should validate_presence_of(:token) }
  #   it { should validate_uniqueness_of(:name) }
  #   it { should validate_uniqueness_of(:token) }
end
