class UserController < ApplicationController
	
	skip_before_filter :find_user
	before_filter :destroy_user_session, :except => [:show, :password_remember]
	before_filter :authorize, :only => [:show,:edit]
	
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
		if params[:user]
			user = User.authenticate(params[:user][:username],params[:user][:password])
			if user
				session[:user_id] = user.id
				original_uri = flash[:original_uri]
				redirect_to (original_uri || root_path)
			else
				@user = User.new()
				@login_failed = true
				@user.errors.add(:username,'')
				@user.errors.add(:password,'')
			end
		else
			@user = User.new()
		end
  end

	def registration		
		@user = User.new(params[:user])
		if @user.save
			flash[:notice] = I18n.t 'user.registration.succeed'
			
			if request.request_uri == registration_url
				redirect_to root_path
			else
				redirect_to order_address_path
			end
		end
	end
	
	def password_remember
	end

  def logout
		redirect_to root_path
  end

	def show
	end
	
	def edit
		@user = User.new(params[:user])
		render :action => show
	end

	private
	def destroy_user_session
		session[:user_id] = nil
	end

end
