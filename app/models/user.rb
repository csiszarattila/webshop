class User < ActiveRecord::Base
	belongs_to :group, :class_name => "UserGroup"
	
	validates_presence_of :username, :hashed_password, :salt
	validates_uniqueness_of :username
	
	# A felhasználónév nem tartalmazhat ékezetes karaktert sem szüntet
	validates_format_of :username, :with => /\A[_0-9a-zA-Z]+\Z/, 
		:message  => "A felhasználónév nem tartalmazhat ékezetes karaktert sem szüntet."
		
end
