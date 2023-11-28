class ItemsController < ApplicationController
  def show
    @item = Item.find(params[:id])
    @accompagnements = Item.where(dishes_type: 'accompagnement')
    @order = Order.new
    @restaurant = Restaurant.find(params[:restaurant_id])
  end

end
