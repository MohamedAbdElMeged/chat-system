FactoryBot.define do
  factory :message do
    body { Faker::Lorem.characters(number: 50) }
    chat
  end
end
