# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end

puts "Cleaning database..."
Category.destroy_all
Restaurant.destroy_all
RestaurantCategory.destroy_all 
Item.destroy_all

puts "Creating categories..."
10.times do
  Category.create(
    name: Faker::Restaurant.type 
  )
end

puts "Creating Restaurants..."
10.times do
  restaurant = Restaurant.create!(
    name: Faker::Restaurant.name,
    address: Faker::Address.street_address,
    latitude: Faker::Address.latitude,
    longitude: Faker::Address.longitude,
  )

  file = URI.open('https://source.unsplash.com/1600x900/?restaurant')
  restaurant.photo.attach(io: file, filename: 'nes.png', content_type: 'image/png')

end

puts "Creating RestaurantCategories..."
10.times do
  RestaurantCategory.create(
    restaurant: Restaurant.all.sample,
    category: Category.all.sample
  )
end

puts "Creating Items..."
10.times do
  Item.create(
    name: Faker::Food.dish,
    price: Faker::Number.decimal(l_digits: 2),
    restaurant: Restaurant.all.sample,
    dishes_type: ["accompagnement","plat","dessert","boisson"].sample
  )
end

puts "Finished!"