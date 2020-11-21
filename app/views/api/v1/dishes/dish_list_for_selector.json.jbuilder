json.array! @dishes do |dish|
  json.id dish.id
  json.label dish.name
  json.selectable true
end
