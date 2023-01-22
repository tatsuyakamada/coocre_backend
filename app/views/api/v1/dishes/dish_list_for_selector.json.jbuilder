# frozen_string_literal: true

json.array! @dishes do |dish|
  json.id dish.id
  json.label dish.name
  json.category dish.category
  json.selectable true
end
