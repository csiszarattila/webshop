class Product < ActiveRecord::Base
	belongs_to :category
	has_and_belongs_to_many :attributes, :join_table => "product_attributes"
end
