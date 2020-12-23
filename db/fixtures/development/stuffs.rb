require 'csv'

csv = CSV.read('db/fixtures/stuffs.csv')

csv.each do |line|
  id = line[0]
  sub_category = line[1]
  name = line[2]

  Stuff.seed(:id) do |stuff|
    stuff.id = id
    stuff.sub_category_id = sub_category
    stuff.name = name
  end
end
