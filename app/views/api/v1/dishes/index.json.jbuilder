json.array! @dishes do |dish|
  json.id dish.id
  json.name dish.name
  json.genre dish.genre
  json.category dish.category

  json.dishStuffs do
    json.array! dish.dish_stuffs.order(:category) do |dish_stuff|
      json.id dish_stuff.id
      json.category dish_stuff.category
      json.stuffId dish_stuff.stuff_id
      json.stuffName dish_stuff.stuff.name
    end
  end
end
