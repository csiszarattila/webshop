class Product < ActiveRecord::Base
	belongs_to :category
	has_many :attrs, :class_name => "ProductAttribute" 
	has_many :category_attributes, :through => :attrs
	has_and_belongs_to_many :labels

	validates_presence_of 		:name, :price, :category_id
	# Minimun ar >= 1 Ft es egesz szam
	# Minumun price must be >= 1 Ft and must be integer
	validates_numericality_of :price, :only_integer => true, :greater_than_or_equal_to => 1
end
