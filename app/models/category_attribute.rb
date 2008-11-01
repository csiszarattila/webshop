class CategoryAttribute < ActiveRecord::Base
	belongs_to :category
	has_many :values, :class_name => "ProductAttribute"

# 
# Validációk
# 
	validates_presence_of :name
	
	def format_to_regexp
		Regexp.new(format)
	end
end
