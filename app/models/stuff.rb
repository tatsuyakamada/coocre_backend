# frozen_string_literal: true

class Stuff < ApplicationRecord
  belongs_to :sub_category
  delegate :category, to: :sub_category
  has_many :dish_stuffs, dependent: :destroy
  has_many :dishes, through: :dish_stuffs

  validates :name, presence: true, uniqueness: { case_sensitive: true }
end
