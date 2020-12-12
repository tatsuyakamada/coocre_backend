FactoryBot.define do
  factory :menu do
    schedule_id { 1 }
    dish_id { 1 }
    category { 'main' }
    memo { Faker::Lorem.sentence }
  end
end
