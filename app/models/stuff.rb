class Stuff < ApplicationRecord
  belongs_to :sub_category
  delegate :category, to: :sub_category

  validates :name, presence: true, uniqueness: { case_sensitive: true }
end
