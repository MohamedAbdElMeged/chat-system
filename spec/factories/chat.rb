FactoryBot.define do
  factory :chat do
    application
    messages_count { 0 }
  end
end
