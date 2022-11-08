require 'rails_helper'

RSpec.describe Chat, type: :model do
  let!(:application) { create :application }
  let!(:counter) { 0 }
  before(:each) do
    counter = + 1
  end
  let!(:chat) { create :chat, application_token: application.token, application: application, number: counter }

  it 'message count should be 0 and chat number should be 1' do
    expect(chat.messages_count).to eq(0)
    expect(chat.number).to eq(counter)
  end
end
