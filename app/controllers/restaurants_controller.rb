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
    @pending_orders = current_user.orders.select{|order| order.status == "pending" && order.restaurant_id == params[:id]}
    @pending_orders.last.present? ? @order = @pending_orders.last.id : @order = Order.create(user_id: current_user.id, restaurant_id: params[:id], status: "pending", total_price: 0)

  end

  def quizz
    if params[:quiz].present?
      selected_restriction = Category.find(params[:quiz][:restriction].to_i)
      selected_humeur = Category.find(params[:quiz][:humeur].to_i)
      @restaurants = Restaurant.select do |restaurant| 
        restaurant.categories.pluck(:name).include?(selected_humeur.name) && restaurant.categories.pluck(:name).include?(selected_restriction.name)
      end
      if @restaurants.empty?
        redirect_to root_path, notice: "Aucun restaurant ne correspond à votre recherche" 
      else  
        render :results
      end  
    else
      @restaurants = Restaurant.all
    end
  end
end
