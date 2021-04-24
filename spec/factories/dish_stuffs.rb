FactoryBot.define do
  factory :dish_stuff do
    dish_id { create(:dish).id }
    stuff_id { create(:stuff).id }
    category { DishStuff.categories.values.sample }
  end
end
