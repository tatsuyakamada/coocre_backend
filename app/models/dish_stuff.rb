# frozen_string_literal: true

class DishStuff < ApplicationRecord
  belongs_to :dish
  belongs_to :stuff

  enum category: { essential: 0, desireble: 1, optional: 2 }

  validate :duplicate?

  def duplicate?
    errors.add(:dish_id, 'duplicated!') if DishStuff.where(dish_id: dish_id, stuff_id: stuff_id).where.not(id: id).count.positive?
  end
end
