class Cart < ActiveRecord::Base
  has_many :line_items
  has_many :items, through: :line_items
  has_many :orders

  def add_item(item_id)
    @line_item = LineItem.where(item_id: item_id, cart_id: self.id).first
    if @line_item
      @line_item.quantity += 1
      @line_item.save
    else
      @line_item = LineItem.create(cart_id: self.id, item_id: item_id, quantity: 1)
    end
    @line_item
  end

  def total
    prices = self.line_items.map do |line_item|
      quantity = line_item.quantity
      price = line_item.item.price
      quantity * price
    end
    prices.inject(:+)
  end
end
