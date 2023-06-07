FactoryBot.define do
  factory :user do
    device_token { SecureRandom.uuid }
  end
end
