FactoryBot.define do
  factory :sub_category do
    category { create(:category) }
    name { Faker::Lorem.unique.word }
  end
end
