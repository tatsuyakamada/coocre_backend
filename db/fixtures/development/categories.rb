require 'csv'

csv = CSV.read('db/fixtures/categories.csv')

csv.each do |line|
  id = line[0]
  name = line[1]

  Category.seed(:id) do |category|
    category.id = id
    category.name = name
  end
end
