class ProductsController < ApplicationController	
	def show
		@product = Product.find(params[:id])
		@current_category = set_current_category(@product.category)
	end
end
