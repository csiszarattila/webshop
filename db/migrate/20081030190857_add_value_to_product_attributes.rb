class AddValueToProductAttributes < ActiveRecord::Migration
  def self.up
    add_column :product_attributes, :value, :string
  end

  def self.down
    remove_column :product_attributes, :value
  end
end
