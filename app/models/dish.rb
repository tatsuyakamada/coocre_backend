class Dish < ApplicationRecord
  has_many :menus, dependent: :restrict_with_error
  has_many :schedules, through: :menus

  enum genre: { japanese: 0, western: 1, chinese: 2, other: 3 }, _suffix: :dish
  enum category: { main: 0, side: 1, dessert: 2, other: 3 }

  validates :name, presence: true, uniqueness: true
  validates :genre, presence: true
  validates :category, presence: true
end
