class Admin::UsersController < AdminController
  def index
		@users = UserGroup.find_by_name("admin").users
  end

  def edit
		@user = User.find(params[:id])
  end

  def new
		@user = User.new()
  end

  def create
		@user = User.create_an_admin(params[:user])
		if @user.valid?
			flash[:notice] = I18n.t 'user.created'
			redirect_to admin_users_path
		else
			render :action => "new"
		end
  end

  def update
		@user = User.find(params[:id])
		if @user.update_attributes params[:user]
			flash[:notice] = I18n.t 'user.updated'
			redirect_to admin_users_path
		else
			render :action => "edit"
		end
  end

  def destroy
		@user = User.find(params[:id])
		@user.destroy
		flash[:notice] = I18n.t 'user.destroyed'
		redirect_to :action => "index"
  end

end
