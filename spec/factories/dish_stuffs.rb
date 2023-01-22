FactoryBot.define do
  factory :dish_stuff do
    association :dish, strategy: :create
    association :stuff, strategy: :create
    category { DishStuff.categories.values.sample }
  end
end
