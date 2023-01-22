FactoryBot.define do
  factory :stuff do
    association :sub_category
    name { Faker::Lorem.characters }
  end
end
