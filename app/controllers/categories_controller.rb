class CategoriesController < ApplicationController
	before_filter :find_root_categories
	
  def show
		@category = Category.find(params[:id])
  end
end
