class Cart < ActiveRecord::Base
  has_many :line_items
  has_many :items, through: :line_items
  has_many :orders

  def add_item(item_id)
    if LineItem.where(item_id: "#{item_id}").empty?
      @line_item = LineItem.new
      @line_item.cart_id = self.id
      @line_item.item_id = item_id
      @line_item.quantity = 1
    else
      li = LineItem.where(item_id: "#{item_id}").first
      li.quantity += 1
      @line_item = li
      # binding.pry
      # LineItem.where(item_id: "#{item_id}").map do |line_item|
      #   line_item.quantity = (line_item.quantity + 1)
      #   line_item.save
      #   @line_item.quantity = line_item.quantity
      # end
    end
    @line_item
  end

  def total
    product = Hash.new
    self.items.map do |item|
      product["#{item.title}"] = {}
      product["#{item.title}"][:id] = item.id
      product["#{item.title}"][:price] = item.price
    end

    self.line_items.map do |line_item|
      product[line_item.item.title][:quantity] = line_item.quantity
    end

    total = []
    product.each do |item|
      total << item.last[:price] * item.last[:quantity]
    end
    total.inject(:+)
    # total = self.items.first.price * self.line_items.first.quantity
  end

end
