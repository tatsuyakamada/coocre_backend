class Dish < ApplicationRecord
  has_many :menus
  has_many :objects, through: :menu

  enum genre: { japanese: 0, western: 1, chinese: 2, other: 3 }

  validates :name, presence: true, uniqueness: true
end
