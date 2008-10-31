class Product < ActiveRecord::Base
	belongs_to :category
	has_many :attrs, :class_name => "ProductAttribute" 
	has_many :category_attributes, :through => :attrs
end
