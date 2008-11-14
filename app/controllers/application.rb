# Filters added to this controller apply to all controllers in the application.
# Likewise, all the methods added will be available for all controllers.

class ApplicationController < ActionController::Base
  helper :all # include all helpers, all the time

  # See ActionController::RequestForgeryProtection for details
  # Uncomment the :secret if you're not using the cookie session store
  protect_from_forgery :secret => 'fa9ea2b4ea609e4220da3fdf055d6b6a'
  
  # See ActionController::Base for details 
  # Uncomment this to filter the contents of submitted sensitive data parameters
  # from your application log (in this case, all fields with names like "password"). 
  # filter_parameter_logging :password

	before_filter :find_root_categories
	before_filter :find_cart
	before_filter :show_cart
	
	private
	def find_root_categories
		@categories = Category.roots
	end
	
	def find_cart
		@cart = session[:cart]
	end
	
	def show_cart
		@show_cart ||= true
	end
	
	def authorize
		
		@user = User.find_by_id(session[:user_id])
		unless @user
			flash[:error] = "Nincs jogod ezt a funkciót elérni!"
			redirect_to login_path
		end
	end
end
