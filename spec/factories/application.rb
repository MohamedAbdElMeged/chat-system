FactoryBot.define do
  factory :application do
    name { Faker::Name.name }
    sequence(:token) { |n| "ABCDEZSodf#{n}" }
  end
end
