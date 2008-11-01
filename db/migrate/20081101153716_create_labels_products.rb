class CreateLabelsProducts < ActiveRecord::Migration
  def self.up
		create_table :labels_products, :id => false do |t|
			t.references :label
			t.references :product
		end
  end

  def self.down
		drop_table :labels_products
  end
end
