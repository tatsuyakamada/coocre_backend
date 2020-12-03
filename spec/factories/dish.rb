FactoryBot.define do
  factory :dish do
    name { Faker::Food.dish }
    genre { Dish.genres.keys.sample }
  end
end
