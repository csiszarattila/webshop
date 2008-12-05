class UserGroup < ActiveRecord::Base
	has_many :users, :foreign_key => 'group_id'
	
	validates_presence_of :name
	validates_uniqueness_of :name
end
