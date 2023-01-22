# frozen_string_literal: true

class Menu < ApplicationRecord
  belongs_to :schedule
  belongs_to :dish
  has_one_attached :image

  enum category: { main: 0, side: 1, dessert: 2, other: 3 }

  validates_presence_of :category
  validates_uniqueness_of :dish, scope: :schedule
end
