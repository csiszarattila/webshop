class CreateOrderItems < ActiveRecord::Migration
  def self.up
    create_table :order_items do |t|
			t.decimal :total_price, :decimal, :precision => 8
			t.integer :quantity
			t.references :order, :product
    end
  end

  def self.down
    drop_table :order_items
  end
end
