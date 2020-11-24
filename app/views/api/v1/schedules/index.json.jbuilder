json.array! @schedules do |schedule|
  json.schedule do
    json.id schedule.id
    json.date schedule.date
    json.category schedule.category
    json.images schedule.images.attached? ? schedule.images.map { |image| rails_blob_url(image) } : nil
  end
  json.menus do
    json.array!(schedule.menus.order(:category)) do |menu|
      json.id menu.id
      json.category menu.category
      json.dishId menu.dish_id
      json.dishName menu.dish.name
      json.image menu.image.attached? ? rails_blob_url(menu.image) : nil
    end
  end
end
