FactoryBot.define do
  factory :category do
    name { Faker::Food.dish }
  end
end
