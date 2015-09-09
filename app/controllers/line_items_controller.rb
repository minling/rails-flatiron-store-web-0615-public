class LineItemsController < ApplicationController

  def create
    # binding.pry
    # this is where we go when we clikc "add to cart"
    if session[:cart_id] == nil
      # binding.pry
      @cart = Cart.create
      session[:cart_id] = @cart.id
      @item = Item.find(params[:item_id])
      @line_item = @cart.add_item(@item.id)
      @line_item.save
      # @cart.line_items << @line_item
    else
      @cart = Cart.find(session[:cart_id])
      @item = Item.find(params[:item_id])
      # binding.pry
      @line_item = @cart.add_item(@item.id)
      @line_item.save
      @cart.line_items << @line_item
    end
    redirect_to cart_path(@cart)
  end
end

