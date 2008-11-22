class RenameLabelsToTags < ActiveRecord::Migration
  def self.up
		drop_table :labels_products
		create_table :products_tags, :id => false do |t|
			t.references :tag, :product
		end
  end

  def self.down
		create_table :labels_products, :id => false do |t|
			t.references :label, :product
		end
  end
end
