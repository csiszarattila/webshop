class Admin::UserController < AdminController
  def index
		@users = User.admins
  end

  def edit
  end

  def new
  end

  def update
  end

  def destroy
  end

  def create
  end

end
