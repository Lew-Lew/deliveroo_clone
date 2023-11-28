class Restaurant < ApplicationRecord
  has_many :restaurant_categories, dependent: :destroy
  has_many :categories, through: :restaurant_categories
  has_many :orders, dependent: :destroy
  has_many :items, dependent: :destroy
  has_one_attached :photo

  validates :name, :address, presence: true
end
