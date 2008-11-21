class AdminController < ApplicationController
	
	before_filter :authorize_as_admin
	layout "admin"
	
	def index
	end
end