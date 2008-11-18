class AddAdminNotesInOrders < ActiveRecord::Migration
  def self.up
		add_column :orders, :admin_notes, :text
  end

  def self.down
		remove_column :orders, :admin_notes
  end
end
