require 'rails_helper'
describe ApplicationService::CreateApplication do
  let!(:name) { Faker::Lorem.characters(number: 25) }
  subject(:result) { described_class.new(name) }
  subject(:application) { result.call }
  describe '.new' do
    it 'should initialize name , token variables' do
      expect(result.name).to match(name)
      expect(result.token).to be_present
    end
  end
  describe '.call' do
    it 'should create application successfully' do
      expect(application.name).to match(name)
      expect(application.token).to match(result.token)
      expect(application.chats_count).to eq(0)
    end
  end
end
