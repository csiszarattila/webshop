class CreateOrderTypes < ActiveRecord::Migration
  def self.up
    create_table :order_types do |t|
      t.string :name
    end
  end

  def self.down
    drop_table :order_types
  end
end
