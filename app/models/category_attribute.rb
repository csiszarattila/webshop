class CategoryAttribute < ActiveRecord::Base
	belongs_to :category
	has_many :values, :class_name => "ProductAttribute"
end
