class LineItemsController < ApplicationController

  def create
    @item = Item.find(params[:item_id])
    current_cart = Cart.create
    @line_item = LineItem.create(cart_id: current_cart.id, item_id: @item.id)
    current_cart.line_items << @line_item
    redirect_to cart_path(current_cart)
  end
end

