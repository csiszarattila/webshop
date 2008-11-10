class MainController < ApplicationController
  def index
		@categories = Category.top 
  end
end
