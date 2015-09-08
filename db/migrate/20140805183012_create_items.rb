class CreateItems < ActiveRecord::Migration
  def change
    create_table :items do |t|
      t.string :title 
      t.integer :price
      t.integer :inventory
    end
  end
end
