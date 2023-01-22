# frozen_string_literal: true

class Schedule < ApplicationRecord
  has_many :menus, -> { order('category ASC') }, dependent: :destroy, inverse_of: :schedule
  has_many :dishes, through: :menus
  has_many_attached :images

  enum category: { morning: 0, lunch: 1, dinner: 2, brunch: 3 }

  validates_presence_of :date, :category
end
