class MainController < ApplicationController
	before_filter :find_root_categories
	
  def index
  end
end
