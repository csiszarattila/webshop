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
	
	# Beállítja az aktuális categóriát a kategória menüben
	def set_current_category(category)
		if category.is_root?
			@categories.delete(category)
			elements = {:root => category, :ancestors => category.ancestors}
		else
			@categories.delete(category.root)
			ancestors = category.ancestors
			elements = {:root => ancestors.pop, :ancestors => ancestors }
		end
		elements.merge!({:current => category, :children => category.children})
	end
	
	def find_cart
		@cart = session[:cart]
	end
	
	def show_cart
		@show_cart ||= true
	end
	
	def destroy_cart
		session[:cart] = nil
		@cart = nil
	end
	
	MAX_SESSION_TIME = 20.minutes
	
	def check_session_expiry_time
		if session[:expiry_time] or session[:expiry_time] < Time.now()
			session[:user_id] = nil
			return
		end
		session[:expiry_time] = MAX_SESSION_TIME.from_now()
	end
	
	before_filter :check_session_expiry_time, :only => [:authorize_as_admin, :authorize_as_customer]

	def authorize_as_admin
		@admin = User.find_by_id(session[:user_id])
		unless @admin
			flash[:error] = "Nincs jogod ezt a funkciót elérni!"
			flash[:original_uri] = request.request_uri
			redirect_to admin_login_path
		end
		
	end
	
	# Logged in user has to be a +Customer+
	def authorize_as_customer
			customer = Customer.find_by_user_id(session[:user_id])
			unless customer
				redirect_to login_or_registration_path
			else
				@customer = customer
			end
	end
end
