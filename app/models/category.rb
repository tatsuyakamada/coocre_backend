class Category < ApplicationRecord
  has_many :sub_categories, dependent: :restrict_with_error
  has_many :stuffs, through: :sub_categories

  validates :name, presence: true, uniqueness: true
end
