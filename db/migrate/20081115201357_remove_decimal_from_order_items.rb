class RemoveDecimalFromOrderItems < ActiveRecord::Migration
  def self.up
		remove_column :order_items, :decimal
  end

  def self.down
		add_column :order_items, :decimal, :integer, :limit => 8, :precision => 8, :scale => 0
  end
end
