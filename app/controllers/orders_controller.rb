class OrdersController < ApplicationController

  def new
    @order = Order.new
    @order.order_items.build
    @restaurant = Restaurant.find(params[:restaurant_id])
  end
  
  def create
    @order = Order.new(order_params)
    @order.restaurant = Restaurant.find(params[:restaurant_id])
    @order.user = current_user
    @order.status = "pending"
    @item = Item.find(params[:order][:order_items][:item_id])
    @accompagnement = Item.find(params[:order][:order_items][:accompagnement_id])
    @order.total_price = @item.price
    if @order.save!
      @order.items << @item
      @order.items << @accompagnement
      redirect_to restaurant_path(@order.restaurant)
    else
      render "items/show"
    end
  end

  def show
    @order = Order.find(params[:id])
    @restaurant = @order.restaurant
  end
  
  private
  
  def order_params
    params.require(:order).permit(:user_id, :restaurant_id, order_items_attributes: [:item_id, :accompagnement_id])
  end
  
  
end

