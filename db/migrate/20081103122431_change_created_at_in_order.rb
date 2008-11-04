class ChangeCreatedAtInOrder < ActiveRecord::Migration
  def self.up
		change_column :orders, :created_at, :datetime
  end

  def self.down
		change_column :orders, :created_at, :timestamp
  end
end
