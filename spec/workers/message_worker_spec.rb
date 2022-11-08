require 'rails_helper'

RSpec.describe MessageWorker do
  let!(:application) { create :application }
  let!(:chat) { create :chat, application: application, application_token: application.token, number: 1 }

  describe '.perform_async' do
    before do
      described_class.perform_async(application.token, chat.id, chat.number, 1, 'Hello World')
    end
    it 'should create job' do
      expect(described_class.jobs.size).to eq 1
    end
  end
end
