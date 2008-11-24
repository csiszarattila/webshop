class ChangeProductAttributes < ActiveRecord::Migration
  def self.up
		drop_table :product_attributes # old schema hasnt got id
	  create_table :product_attributes, :id=>true do |t|
			t.references :product
			t.references :category_attribute
			t.string :value
		end
	end

  def self.down
  end
end
