class AddTelAndEmailToAddress < ActiveRecord::Migration
  def self.up
    add_column :addresses, :tel, :string
    add_column :addresses, :email, :string
  end

  def self.down
    remove_column :addresses, :email
    remove_column :addresses, :tel
  end
end
