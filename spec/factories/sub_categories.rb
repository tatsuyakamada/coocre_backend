FactoryBot.define do
  factory :sub_category do
    association :category
    name { Faker::Lorem.unique.word }
  end
end
