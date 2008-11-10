class AddDescriptionToProductImages < ActiveRecord::Migration
  def self.up
    add_column :product_images, :description, :string
  end

  def self.down
    remove_column :product_images, :description
  end
end
