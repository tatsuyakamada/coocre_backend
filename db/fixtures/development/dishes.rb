require 'csv'

csv = CSV.read('db/fixtures/dishes.csv')

csv.each do |line|
  id = line[0]
  name = line[1]
  genre = line[2]
  category = line[3]

  Dish.seed(:id) do |dish|
    dish.id = id
    dish.name = name
    dish.genre = genre
    dish.category = category
  end
end
