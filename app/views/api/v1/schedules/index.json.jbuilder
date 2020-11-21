json.array! @schedules do |schedule|
  json.schedule do
    json.id schedule.id
    json.date schedule.date
    json.category schedule.category
    json.image schedule.image.attached? ? rails_blob_url(schedule.image) : nil
  end
  json.menus do
    json.array!(schedule.menus.order(:category)) do |menu|
      json.id menu.id
      json.category menu.category
      json.dishId menu.dish_id
      json.dishName menu.dish.name
    end
  end
end
