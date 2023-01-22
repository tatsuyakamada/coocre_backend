FactoryBot.define do
  factory :menu do
    association :schedule
    association :dish, strategy: :create
    category { 'main' }
    memo { Faker::Lorem.sentence }
  end
end
