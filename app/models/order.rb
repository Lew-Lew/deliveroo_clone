class Order < ApplicationRecord
  belongs_to :user
  belongs_to :restaurant
  has_many :order_items
  has_many :items, through: :order_items

  validates :status, presence: true, inclusion: { in: %w[pending confirmed delivered] }
  validates :total_price, numericality: true
end
