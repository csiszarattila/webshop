class CreateProductPictures < ActiveRecord::Migration
  def self.up
    create_table :product_pictures do |t|
			t.string :text, :image_url
			t.references :product
    end
  end

  def self.down
    drop_table :product_pictures
  end
end
