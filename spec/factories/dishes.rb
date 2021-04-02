FactoryBot.define do
  factory :dish do
    name { Faker::Food.unique.dish }
    genre { Dish.genres.keys.sample }
    category { Dish.categories.keys.sample }
  end
end
