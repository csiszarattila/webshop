class CreateProductAttributes < ActiveRecord::Migration
  def self.up
    create_table :product_attributes, :id=>false do |t|
			t.references :product
			t.references :category_attribute
    end
  end

  def self.down
    drop_table :product_attributes
  end
end
