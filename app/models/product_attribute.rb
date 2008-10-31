class ProductAttribute < ActiveRecord::Base
	belongs_to :category_attribute
	belongs_to :product
	
	#
	# A x.category_attribute.name elérés helyett x.name 
	# Call x.name explicitly instead of x.category_attribute.name
	# 
	def name
		category_attribute.name
	end
end
