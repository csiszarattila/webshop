class CreateAddresses < ActiveRecord::Migration
  def self.up
    create_table :addresses do |t|
			t.string :name, :city, :street
			t.decimal :zipcode, :precision => 4
			
			t.references :addressable, :polymorphic => true
    end
  end

  def self.down
    drop_table :addresses
  end
end
