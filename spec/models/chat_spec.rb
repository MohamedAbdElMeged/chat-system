require 'rails_helper'

RSpec.describe Chat, type: :model do
  let!(:application) { create :application }
  let!(:counter) { 0 }
  let!(:chat) { create :chat, application_token: application.token, application: application, number: counter + 1 }

  it 'message count should be 0 and chat number should be 1' do
    expect(chat.messages_count).to eq(0)
    expect(chat.number).to eq(counter)
  end
end
