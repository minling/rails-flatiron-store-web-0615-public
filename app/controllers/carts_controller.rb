class CartsController < ApplicationController

  def show
    @cart = Cart.find(session[:cart_id])
    # binding.pry
  end

  def checkout
    @cart = Cart.find(session[:cart_id])
    @order = Order.create_from_cart(@cart)
    @order.change_order_status
    @order.change_inventory
    # Cart.destroy(@cart.id)
    session[:cart_id] = nil
    redirect_to store_path, notice: "thanks and come again!"
  end
end
