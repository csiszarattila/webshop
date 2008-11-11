class MainController < ApplicationController
  def index
		@categories = Category.roots
  end
end
