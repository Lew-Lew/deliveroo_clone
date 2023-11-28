# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end

require 'open-uri'
require 'faker'

puts "Cleaning database..."
Category.destroy_all
Item.destroy_all
Restaurant.destroy_all
RestaurantCategory.destroy_all 

puts "Creating categories..."
10.times do
  Category.create(
    name: ["vegan","végétarien","sans gluten","sans poisson","halal", "équilibré", "épicé"].sample
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

  puts "Creating Items..."
  10.times do
    restaurant.items.create!(
      name: Faker::Food.dish,
      description: Faker::Food.description,
      price: Faker::Number.between(from: 9, to: 50).to_f,
      dishes_type: ["accompagnement","plat","dessert","boisson"].sample
    )
  end

  puts "Attaching photos to items..."
  Item.all.each do |item|
    # Télécharge une image depuis une URL et l'attache à l'item
    file = URI.open('https://source.unsplash.com/1600x900/?food')
    item.photo.attach(io: file, filename: 'item_image.png', content_type: 'image/png')
end

end

puts "Creating RestaurantCategories..."
10.times do
  RestaurantCategory.create(
    restaurant: Restaurant.all.sample,
    category: Category.all.sample
  )
end



puts "Finished!"