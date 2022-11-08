FactoryBot.define do
  factory :application do
    name { Faker::Name.name }
    token { Faker::Lorem.characters(number: 25) }
  end
end
