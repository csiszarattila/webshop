class CreateZipcodes < ActiveRecord::Migration
  def self.up
		create_table :zipcodes do |t|
			t.integer :zipcode
			t.string	:city
		end
  end

  def self.down
		drop_table :zipcodes
  end
end
