class CreateRestaurantCategories < ActiveRecord::Migration[7.1]
  def change
    create_table :restaurant_categories do |t|
      t.references :category, null: false, foreign_key: true
      t.references :restaurant, null: false, foreign_key: true

      t.timestamps
    end
  end
end
