class Dish < ApplicationRecord
  enum genre: { japanese: 0, western: 1, chinese: 2, other: 3 }

  validates :name, presence: true, uniqueness: true
end
