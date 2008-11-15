class AddUserIdToCustomers < ActiveRecord::Migration
  def self.up
		change_table :customers do |t|
			t.references :user
		end
  end

  def self.down
		change_table :customers do |t|
    	t.remove_references :user
		end
  end
end
