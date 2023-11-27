class Restaurant < ApplicationRecord
  has_many :restaurant_categories, dependent: :destroy
  has_many :categories, through: :restaurant_categories
  has_many :orders
  has_many :items
  has_one_attached :photo

  validates :name, :address, presence: true
end
