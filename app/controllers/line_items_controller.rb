class LineItemsController < ApplicationController

  def create
    if session[:cart_id]
      @cart = Cart.find(session[:cart_id])
      @item = Item.find(params[:item_id])
      @line_item = @cart.add_item(@item.id)
      @line_item.save
    else
      @cart = Cart.create
      session[:cart_id] = @cart.id
      @item = Item.find(params[:item_id])
      @line_item = @cart.add_item(@item.id)
      @line_item.save
    end
    redirect_to cart_path(@cart)
  end
end

