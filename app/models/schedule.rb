class Schedule < ApplicationRecord
  has_many :menus, dependent: :destroy
  has_many :dishes, through: :menus
  has_many_attached :images

  enum category: { morning: 0, lunch: 1, dinner: 2, brunch: 3 }

  validates :date, presence: true
  validates :category, presence: true
end
