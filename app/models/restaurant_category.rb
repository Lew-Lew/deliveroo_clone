class RestaurantCategory < ApplicationRecord
  belongs_to :category
  belongs_to :restaurant
  
  validates :category_id, uniqueness: { scope: :restaurant_id, message: "has already been added to this restaurant" }
end
