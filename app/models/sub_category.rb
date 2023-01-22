# frozen_string_literal: true

class SubCategory < ApplicationRecord
  belongs_to :category
  has_many :stuffs, dependent: :restrict_with_error

  validates_presence_of :name
end
