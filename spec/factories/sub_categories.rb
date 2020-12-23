FactoryBot.define do
  factory :sub_category do
    category { create(:category) }
    name { Faker::Food.dish }
  end
end
