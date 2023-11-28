class ItemsController < ApplicationController
  def show
    @item = Item.find(params[:id])
    @restaurant = Restaurant.find(params[:restaurant_id])
    @accompagnements = @restaurant.items.where(dishes_type: 'accompagnement')
  end

  def add_to_session
    item_id = params[:item][:item_id]
    accompagnement_id = params[:accompagnement_id]

    # Création de la session avec un array vide
    session[:current_order][:order_items]  = []

    # Ajoute l'item et son accompagnement à la session
    session[:current_order][:order_items] << { item_id: item_id, accompagnement_id: accompagnement_id }
    @order = Order.create(user_id: current_user.id, restaurant_id: params[:restaurant_id], status: "pending", total_price: 0)
    @item =OrderItem.create!(item_id: item_id, order_id: @order.id)
    @accompagnement = OrderItem.create!(item_id: accompagnement_id, order_id: @order.id)

    redirect_to restaurant_path(params[:restaurant_id]), notice: "Item ajouté à la commande temporairement !"
  end

end
