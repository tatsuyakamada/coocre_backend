# frozen_string_literal: true

json.array! @stuffs do |stuff|
  json.id stuff.id
  json.name stuff.name
  json.selectable true
end
