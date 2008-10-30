class CreateProducts < ActiveRecord::Migration
  def self.up
    create_table :products do |t|
      t.string :name
			t.column :price, :decimal, :precision => 8
			t.references :category
    end
  end

  def self.down
    drop_table :products
  end
end
