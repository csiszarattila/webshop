class CreateCategoryAttributes < ActiveRecord::Migration
  def self.up
    create_table :category_attributes do |t|
      t.string :name, :format
      t.references :category
    end
  end

  def self.down
    drop_table :category_attributes
  end
end
