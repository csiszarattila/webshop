class MainController < ApplicationController
	before_filter :find_root_categories
	
  def index
  end

	def search
		@products = Product.search(params[:name])
	end
	
	def info
	end
end
