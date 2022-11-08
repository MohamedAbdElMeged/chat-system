require 'rails_helper'

RSpec.describe 'Application', type: :model do
  it 'is valid with valid and unique attributes' do
    name = 'Test'
    token = 'token12345'
    expect(Application.create(name: name, token: token)).to be_valid
    expect(Application.create(name: name, token: token)).to_not be_valid
  end

  it 'is not valid when name isn\'t present' do
    token = 'token12345'
    expect(Application.new(token: token)).to_not be_valid
  end
  it 'is not valid when token isn\'t present' do
    name = 'Test'
    expect(Application.new(name: name)).to_not be_valid
  end
end
