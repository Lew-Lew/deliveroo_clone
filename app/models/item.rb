class Item < ApplicationRecord
  belongs_to :restaurant
  has_many :order_items

  validates :name, :price, :description, :type, presence: true
end
