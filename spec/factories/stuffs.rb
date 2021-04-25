FactoryBot.define do
  factory :stuff do
    sub_category { create(:sub_category) }
    name { Faker::Lorem.characters }
  end
end
