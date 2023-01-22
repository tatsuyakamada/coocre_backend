# frozen_string_literal: true

json.array! @categories do |category|
  json.id category.id
  json.name category.name
  json.type 'category'

  json.childs do
    json.array! category.sub_categories do |sub_category|
      json.id sub_category.id
      json.name sub_category.name
      json.type 'subCategory'

      json.childs do
        json.array! sub_category.stuffs do |stuff|
          json.id stuff.id
          json.name stuff.name
          json.type 'stuff'
        end
      end
    end
  end
end
