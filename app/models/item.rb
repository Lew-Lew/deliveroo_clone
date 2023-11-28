class Item < ApplicationRecord
  belongs_to :restaurant
  has_many :order_items, dependent: :destroy
  has_one_attached :photo


  validates :name, :price, :description, :dishes_type, presence: true
end
