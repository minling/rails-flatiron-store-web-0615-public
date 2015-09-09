require 'rails_helper'  

RSpec.describe Cart, :type => :model do
  before do 
    @item = Item.first
    @line_item = Cart.first.add_item(@item.id)
    @line_item.save
  end

  context 'items' do 
    it 'has many line_items built through instance method' do 
      expect(Cart.first.line_items).to include(@line_item)
    end

    it 'has many items through line_items' do
      expect(Cart.first.items).to include(@item)
    end
  end

  it 'can calculate its total' do 
    # binding.pry
    @item = Item.last
    @cart = Cart.first 
    @line_item = @cart.add_item(@item.id)
    @line_item.save
    expect(@cart.total).to eq(@line_item.item.price + @cart.line_items.first.item.price)
  end

  it 'can calculate the total when there are more than one of the same item' do 
    @item_a = Item.last
    @cart = Cart.first 
    @line_item1 = @cart.add_item(@item_a.id)
    @line_item1.save
    @line_item2 = @cart.add_item(@item_a.id)
    @line_item2.save

    total = (@item_a.price * 2) + @cart.items.first.price
    expect(@cart.total).to eq(total)
  end

  it 'consolidates multiple same line_items in add_item method' do 
    @line_item2 = Cart.first.add_item(@item.id)
    @line_item2.save
    expect(Cart.first.line_items.first.quantity).to eq(2)
  end
end
