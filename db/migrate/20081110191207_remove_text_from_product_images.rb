class RemoveTextFromProductImages < ActiveRecord::Migration
  def self.up
		remove_column :product_images, :text
  end

  def self.down
		add_column :text, :product_images
  end
end
