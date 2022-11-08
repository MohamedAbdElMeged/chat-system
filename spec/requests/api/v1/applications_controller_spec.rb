require 'rails_helper'

RSpec.describe 'Api::V1::ApplicationsControllers', type: :request do
  describe 'GET /index' do
    before do
      FactoryBot.create_list(:application, 10)
      get '/api/v1/applications'
    end

    it 'returns http success' do
      expect(json.size).to eq(10)
      expect(response.status).to eq(200)
    end
    it 'should  perform under 30 ms' do
      expect { get '/api/v1/applications' }.to perform_under(30).ms
    end
  end
  describe 'Show /applications/:token' do
    let!(:application) { create :application }
    before do
      get "/api/v1/applications/#{application.token}"
    end
    it 'returns application token' do
      expect(json['token']).to eq(application.token)
    end
    it 'returns application name' do
      expect(json['name']).to eq(application.name)
    end
    it 'returns application chats count' do
      expect(json['chats_count']).to eq(application.chats_count)
    end
    it 'should  perform under 15 ms' do
      expect { get "/api/v1/applications/#{application.token}" }.to perform_under(15).ms
    end
  end
  describe 'Create /applications' do
    context 'with valid paramter name' do
      before do
        post '/api/v1/applications', params: { name: 'TEST' }
      end

      it 'returns the name' do
        expect(json['name']).to eq('TEST')
      end
      it 'returns a created status' do
        expect(response).to have_http_status(:created)
      end
      it 'should  perform under 10 ms' do
        expect { post '/api/v1/applications', params: { name: 'TEST' } }.to perform_under(10).ms.sample(10).times
      end
    end
    context 'with not valid paramter name' do
      let!(:application) { create :application, name: 'TEST' }
      before do
        post '/api/v1/applications', params:
                          { name: 'TEST' }
      end

      it 'raise an error' do
        expect(json['name']).to eq(['has already been taken'])
      end
      it 'returns Unprocessable Entity status' do
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end
  describe 'DELETE /applications' do
    let!(:application) { create :application }
    before do
      delete "/api/v1/applications/#{application.token}"
    end
    it 'delete it successfully' do
      expect(response).to have_http_status(:no_content)
    end
  end
end
