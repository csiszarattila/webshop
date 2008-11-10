class RenameProductPicturesTable < ActiveRecord::Migration
  def self.up
		rename_table :product_pictures, :product_images
  end

  def self.down
		rename_table :product_images, :product_pictures
  end
end
