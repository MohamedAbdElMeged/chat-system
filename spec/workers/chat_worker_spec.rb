require 'rails_helper'

RSpec.describe ChatWorker do
  let!(:application) { create :application }
  let!(:chat_number) { 1 }
  describe '.perform_async' do
    before do
      described_class.perform_async(application.id, application.token, chat_number)
    end
    it 'should create job' do
      expect(described_class.jobs.size).to eq 1
    end
  end
end
