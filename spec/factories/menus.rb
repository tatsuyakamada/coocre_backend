FactoryBot.define do
  factory :menu do
    schedule_id { create(:schedule).id }
    dish_id { create(:dish).id }
    category { 'main' }
    memo { Faker::Lorem.sentence }
  end
end
