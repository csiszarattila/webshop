class UserController < ApplicationController
	
	skip_before_filter :find_user
	before_filter :destroy_user_session, :except => [:show, :edit, :password_remember]
	before_filter :authorize_as_customer, :only => [:show,:edit]
	
	def login_or_registration
		@user = User.new()
	end
	
	# Checks whether username and password are match with the db ones.
	# For this its use the +User.authenticate+ method and given params
	# params[:username] and params[:password].
	# If authentication succeded sets user's id into a session - session[:user_id]
	# and then redirects to the original url - given with session[:original_uri] -
	# if its not present then uses the url of the 2nd state of the order process.
	# 
	# Ellenőrzi az átadott paramétereket - params[:username] and params[:password] -
	# hogy egyeznek-e az adatbázissal, erre a +User.authenticate+ metódus használja.
	# Ha igen beállítja az felhasználó azonosítóját session-be - session[:user_id] és
	# visszairányít az eredeti url-re, ha session[:original_uri] létezik, máskülönben
	# a rendelés második részére.
  def login
		@user = User.new()	
		if params[:user]
			user = User.authenticate(params[:user][:username],params[:user][:password])
			if user
				session[:user_id] = user.id
				original_uri = flash[:original_uri]
				redirect_to (original_uri || root_path)
			else
				@user.errors.add(:username,'')
				@user.errors.add(:password,'')
			end
		end
  end

	def admin_login
		@user = User.new()
		if params[:user]
			user = User.authenticate(params[:user][:username],params[:user][:password])
			if user
				session[:user_id] = user.id
				original_uri = flash[:original_uri]
				redirect_to (original_uri || admin_root_path) and return
			else
				@user.errors.add(:username,'')
				@user.errors.add(:password,'')
			end
		end
		render :layout => 'admin'
	end
	
	def login_a_user
		@user = User.new()
		if params[:user]
			user = User.authenticate(params[:user][:username],params[:user][:password])
			if user
				session[:user_id] = user.id
				original_uri = flash[:original_uri]
				redirect_to (original_uri || admin_root_path) and return
			else
				@user.errors.add(:username,'')
				@user.errors.add(:password,'')
			end
		end
	end
	# Create a new customer user in the database 
	# 
	# Létrehoz egy új +User+ és +Customer+ modellt a megadott regisztrációs adatokkal
	def registration		
		@user = User.new(params[:user])
		
		if @user.valid?
			@user = User.create_a_customer(@user)
			session[:user_id] = user.id
			flash[:notice] = I18n.t 'user.registration.succeed'
			if request.request_uri == registration_url
				redirect_to root_path
			else
				redirect_to order_address_path
			end
		end
	end
	
	# E-mailt küld a generált új jelszóval
	# Bővebben: User.random_password és ApplicationMailer#password_remember.
	# Csak vásárlókra, +Customer+ osztályúakra működik, 
	# mivel csak az ő e-mail címeiket tároljuk
	def password_remember
		user = User.find_by_username(params[:username])
		if user and ( customer = Customer.find_by_user_id(user.id) )
			user.random_password()
			email = ApplicationMailer.deliver_password_remember(customer.address.email, customer.address.name, user.password)
			#flash[:notice] = I18n.t 'user.password.restored'
			#redirect_to :root
			render :text => email.encoded
		end
	end

	# Unset user's session and redirect
	# 
	# Törli a felhasználó munkamenetét ás átirányít
	# Megjegyzés: a destroy_user_session -t már meghívtuk before_filter-ként
  def logout
		redirect_to root_path
  end

	# Show user's profile
	# 
	# Megmutatja a felhasználó profilját
	def show
		@user = @customer.user
	end
	
	# Change user's profile
	# 
	# Felhasználói adatok megváltoztatása
	def edit
		@user.password = params[:user][:password]
		@user.password_confirmation = params[:user][:password_confirmation]
		@user.save
		render :action => 'show'
	end

	private
	def destroy_user_session
		session[:user_id] = nil
	end

end
