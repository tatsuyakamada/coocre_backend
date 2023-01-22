# frozen_string_literal: true

require 'csv'

csv = CSV.read('db/fixtures/sub_categories.csv')

csv.each do |line|
  id = line[0]
  category = line[1]
  name = line[2]

  SubCategory.seed(:id) do |sub_cateogry|
    sub_cateogry.id = id
    sub_cateogry.category_id = category
    sub_cateogry.name = name
  end
end
