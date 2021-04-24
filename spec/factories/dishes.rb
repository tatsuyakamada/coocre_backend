FactoryBot.define do
  factory :dish do
    name { Faker::Lorem.characters }
    genre { Dish.genres.keys.sample }
    category { Dish.categories.keys.sample }
  end
end
