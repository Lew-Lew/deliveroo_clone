class Category < ApplicationRecord
  has_many :restaurant_categories, dependent: :destroy
  has_many :restaurants, through: :restaurant_categories

  validates :name, presence: true, uniqueness: true
  # j'aimerai faire un scope ou je sélectionne uniquement les catégories qui ont un nom qui contient soit "vegan", soit "végétarien", soit "sans gluten"
  scope :restriction, -> { where(name: ["vegan","végétarien","sans gluten","sans poisson","halal"]) }
  scope :humeur, -> { where(name: ["équilibré", "épicé"]) }

end
