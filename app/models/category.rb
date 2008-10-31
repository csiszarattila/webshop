class Category < ActiveRecord::Base
	has_many :products
	has_many :attrs, :class_name => "CategoryAttribute"
	acts_as_tree :order => "name"
end
