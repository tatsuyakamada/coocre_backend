class SubCategory < ApplicationRecord
  belongs_to :category
  has_many :stuffs, dependent: :restrict_with_error

  validates :name, presence: true
end
