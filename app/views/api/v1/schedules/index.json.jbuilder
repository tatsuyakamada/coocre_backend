json.array! @schedules do |schedule|
  json.schedule do
    json.id schedule.id
    json.date schedule.date
    json.category schedule.category
    json.memo schedule.memo
    json.images do
      if schedule.images.attached?
        json.array! schedule.images do |image|
          json.id image.id
          json.name image.filename.to_s
          json.url rails_blob_url(image)
        end
      else
        nil
      end
    end
  end

  json.menus do
    json.array! schedule.menus.order(:category) do |menu|
      json.id menu.id
      json.category menu.category
      json.dishId menu.dish_id
      json.dishName menu.dish.name
      json.memo menu.memo
      json.image do
        if menu.image.attached?
          json.id menu.image.id
          json.name menu.image.filename.to_s
          json.url rails_blob_url(menu.image)
        else
          nil
        end
      end
    end
  end
end
