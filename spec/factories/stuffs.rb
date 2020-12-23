FactoryBot.define do
  factory :stuff do
    sub_category { create(:sub_category) }
    name { Faker::Food.dish }
  end
end
