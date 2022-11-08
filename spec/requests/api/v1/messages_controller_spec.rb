require 'rails_helper'

RSpec.describe 'Api::V1::MessagesControllers', type: :request do
  describe 'GET /api/v1/applications/:application_token/chats/:chat_number/messages' do
    let!(:application) { create :application }
    let!(:chat) { create :chat, application: application, application_token: application.token, number: 1, messages_count: 0 }
    before do
      FactoryBot.create_list(:message, 10, chat: chat)
      get "/api/v1/applications/#{application.token}/chats/#{chat.number}/messages"
    end
    it 'returns http success' do
      expect(json.size).to eq(10)
      expect(response.status).to eq(200)
    end
  end
  describe 'GET /api/v1/applications/:application_token/chats/:chat_number/messages/:number' do
    let!(:application) { create :application }
    let!(:chat) { create :chat, application: application, application_token: application.token, number: 1, messages_count: 0 }
    context 'when message number is valid' do
      let!(:message) { create :message, application_token: application.token, number: 1, chat: chat, chat_number: chat.number }
      before do
        get "/api/v1/applications/#{application.token}/chats/#{chat.number}/messages/1"
      end
      it 'returns http success' do
        expect(response.status).to eq(200)
      end
      it 'returns chat number' do
        expect(json['number']).to eq(1)
      end
      it 'returns messages count' do
        expect(json['body']).to match(message.body)
      end
    end
    context 'when message number is not valid' do
      before do
        get "/api/v1/applications/#{application.token}/chats/#{chat.number}/messages/873e8378327482374"
      end
      it 'returns http not found' do
        expect(response.status).to eq(404)
      end
      it 'returns error message' do
        expect(json['error']).to match('Message Not Found')
      end
    end
  end

  describe 'POST /api/v1/applications/:application_token/chats/:chat_number/messages/' do
    let!(:application) { create :application }
    let!(:chat) { create :chat, application: application, application_token: application.token, number: 1, messages_count: 0 }
    before do
      post "/api/v1/applications/#{application.token}/chats/#{chat.number}/messages", params:
      {
        message: {
          body: 'Hello World'
        }
      }
    end
    it 'returns message number' do
      expect(json['number']).to eq(1)
    end
    it 'add new job to message worker' do
      expect(MessageWorker).to receive(:perform_async)
      MessageWorker.perform_async(application.token, chat.id, chat.number, 1, 'Hello World')
    end
    it 'returns message body' do
      expect(json['body']).to match('Hello World')
    end
    it 'returns a created status' do
      expect(response).to have_http_status(:created)
    end
  end
  describe 'DELETE /api/v1/applications/:application_token/chats/:chat_number/messages/:number' do
    let!(:application) { create :application }
    let!(:chat) { create :chat, application: application, application_token: application.token, number: 1, messages_count: 0 }
    let!(:message) { create :message, application_token: application.token, number: 1, chat: chat, chat_number: chat.number }
    before do
      delete "/api/v1/applications/#{application.token}/chats/#{chat.number}/messages/#{message.number}"
    end
    it 'returns a 204 no_content status' do
      expect(response).to have_http_status(204)
    end
  end
  describe 'GET /api/v1/applications/:application_token/chats/:chat_number/messages/search' do
    let!(:application) { create :application }
    let!(:chat) { create :chat, application: application, application_token: application.token, number: 1, messages_count: 0 }
    let!(:first_message) do
      create :message, application_token: application.token,
                       number: 1, chat: chat, chat_number: chat.number, body: 'hello world'
    end
    let!(:second_message) do
      create :message, application_token: application.token,
                       number: 1, chat: chat, chat_number: chat.number, body: "I'm Fine"
    end
    before do
      get "/api/v1/applications/#{application.token}/chats/#{chat.number}/messages/search",
          params: { query: 'hel' }
    end
    it 'returns http success' do
      expect(response.status).to eq(200)
    end
    it 'returns first message' do
      expect(json.first['body']).to match(first_message.body)
    end
  end
end
