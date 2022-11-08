require 'rails_helper'

RSpec.describe 'Api::V1::ChatsControllers', type: :request do
  describe 'GET /api/v1/applications/:application_token/chats' do
    let!(:application) { create :application }
    before do
      FactoryBot.create_list(:chat, 10, application: application)
      get "/api/v1/applications/#{application.token}/chats"
    end
    it 'returns http success' do
      expect(json.size).to eq(10)
      expect(response.status).to eq(200)
    end
  end
  describe 'GET /api/v1/applications/:application_token/chats/:number' do
    let!(:application) { create :application }
    context 'when chat number is valid' do
      let!(:chat) { create :chat, application: application, application_token: application.token, number: 1, messages_count: 0 }
      before do
        get "/api/v1/applications/#{application.token}/chats/1"
      end
      it 'returns http success' do
        expect(response.status).to eq(200)
      end
      it 'returns chat number' do
        expect(json['number']).to eq(1)
      end
      it 'returns messages count' do
        expect(json['messages_count']).to eq(0)
      end
    end
    context 'when chat number is not valid' do
      before do
        get "/api/v1/applications/#{application.token}/chats/287387272383"
      end
      it 'returns http not found' do
        expect(response.status).to eq(404)
      end
      it 'returns error message' do
        expect(json['error']).to match('Chat Not Found')
      end
    end
  end
  describe 'POST /api/v1/applications/:application_token/chats/' do
    let!(:application) { create :application }
    before do
      post "/api/v1/applications/#{application.token}/chats"
    end
    it 'add new job to chat worker' do
      expect(ChatWorker).to receive(:perform_async)
      ChatWorker.perform_async(application.id, application.token, 1)
    end

    it 'returns chat number' do
      expect(json['number']).to eq(1)
    end
    it 'returns messages count' do
      expect(json['messages_count']).to eq(0)
    end
    it 'returns a created status' do
      expect(response).to have_http_status(:created)
    end
  end
  describe 'DELETE /api/v1/applications/:application_token/chats/' do
    let!(:application) { create :application }
    let!(:chat) { create :chat, application: application, application_token: application.token, number: 1, messages_count: 0 }
    before do
      delete "/api/v1/applications/#{application.token}/chats/1"
    end
    it 'returns a 204 no_content status' do
      expect(response).to have_http_status(204)
    end
  end
end
