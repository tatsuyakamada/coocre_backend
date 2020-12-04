class Menu < ApplicationRecord
  belongs_to :schedule
  belongs_to :dish
  has_one_attached :image

  enum category: { main: 0, side: 1, dessert: 2, other: 3 }

  validates :schedule_id, presence: true
  validates :dish_id, presence: true
  validates :category, presence: true
  validate :duplicate?

  def duplicate?
    errors.add(:dish_id, 'duplicated!') if Menu.where(schedule_id: schedule_id, dish_id: dish_id).where.not(id: id).count.positive?
  end
end
