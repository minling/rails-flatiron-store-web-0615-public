class Order < ActiveRecord::Base
  belongs_to :cart
  belongs_to :user
  has_many :items, through: :cart

  def self.create_from_cart(cart)
    @order = self.new
    @order.cart_id = cart.id
    @order.total = cart.total
    @order.save
    @order
    # Order(id: integer, status: string, total: integer, user_id: integer, cart_id: integer)
  end

  def change_order_status
    self.status = 'submitted'
    self.save
  end

  def change_inventory
    self.items.each do |item|
      item.inventory
      item.inventory = item.inventory - 1
      item.save
    end
  end
end
