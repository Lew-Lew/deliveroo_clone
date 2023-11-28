class RestaurantsController < ApplicationController
  def index
    @restaurants = Restaurant.all
  end

  def show
    @restaurant = Restaurant.find(params[:id])
    @main_dishes = @restaurant.items.where(dishes_type: "plat")
    @desserts = @restaurant.items.where(dishes_type: "dessert")
    @accompagnements = @restaurant.items.where(dishes_type: "accompagnement")
    @boissons = @restaurant.items.where(dishes_type: "boisson")
  end

  def quizz
    if params[:quiz].present?
      # Récupérer les données du formulaire
      selected_restriction = Category.find(params[:quiz][:restriction].to_i)
      selected_humeur = Category.find(params[:quiz][:humeur].to_i)
      # selected_faim = params[:quiz][:faim]
      # selected_budget = params[:quiz][:budget]
      @restaurants = Restaurant.select do |restaurant| 
        restaurant.categories.pluck(:name).include?(selected_humeur.name) && restaurant.categories.pluck(:name).include?(selected_restriction.name)
      end
      render :results
    else
      @restaurants = Restaurant.all
    end
    # @restaurants = RestaurantCategory.select{|rc| rc.category.name == selected_humeur}
    # .map{|rc| rc.restaurant}
  end
end
