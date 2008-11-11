class CategoriesController < ApplicationController	
  def show
		@category = Category.find(params[:id]) 
		# Find all +Product+ under the category tree
		# Minden +Product+ -ot megkeres a kategóriától lefele a fában
		sort = params[:sort_by] || "name"
		@products = Product.in_category(@category.releated_category_ids).order_by(sort)
	end
end