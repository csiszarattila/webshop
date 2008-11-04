class CreateOrders < ActiveRecord::Migration
  def self.up
    create_table :orders do |t|
			t.timestamp :created_at, :default => nil
			t.references :order_type, :order_state, :customer
    end
  end

  def self.down
    drop_table :orders
  end
end
