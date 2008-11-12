class CategoriesController < ApplicationController	
  def show
		@category = Category.find(params[:id])
		if @category.is_root?
			@categories.delete(@category)
			elements = {:root => @category, :ancestors => @category.ancestors}
		else
			@categories.delete(@category.root)
			ancestors = @category.ancestors
			elements = {:root => ancestors.pop, :ancestors => ancestors }
		end
		@current_category = elements.merge!({:current => @category, :children => @category.children})
		# Find all +Product+ under the category tree
		# Minden +Product+ -ot megkeres a kategóriától lefele a fában
		sort = params[:sort_by] || "name"
		@products = Product.in_category(@category.releated_category_ids).order_by(sort)
	end
end