class CartsController < ApplicationController

  def show
    current_cart = Cart.find(params[:id])
  end

end
