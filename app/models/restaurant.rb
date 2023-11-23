class Restaurant < ApplicationRecord
  has_many :restaurant_categories
  has_many :categories, through: :restaurant_categories
  has_many :orders
  has_many :items

  validates :name, :address, presence: true
  validates :category, inclusion: { in: %w[chinese italian japanese french belgian] }
end
