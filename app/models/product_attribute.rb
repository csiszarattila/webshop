class ProductAttribute < ActiveRecord::Base
	belongs_to :category_attribute
	belongs_to :product
	
#
# Validációk
# 
	validates_presence_of :value, :category_attribute_id
	
# protected
# def validate
# 	if !category_attribute.format.nil? and self.name !~ category_attribute.format_to_regexp
# 		errors.add(:name,"nem illeszkedik a #{category_attribute.format} mintára")
# 	end
# end
	
	public
	#
	# A x.category_attribute.name elérés helyett x.name 
	# Call x.name explicitly instead of x.category_attribute.name
	# 
	def name
		category_attribute.name
	end
end
