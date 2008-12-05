class Admin::CategoriesController < AdminController
	
	before_filter :find_root_categories, :except => [:destroy]
 
	# GET /admin/categories
  # GET /admin/categories.xml
  def index
    @categories = @root_categories

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @categories }
    end
  end

  # GET /admin/categories/new
  # GET /admin/categories/new.xml
  def new
    @category = Category.new
		4.times { @category.attrs.build }
    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @category }
    end
  end

  # GET /admin/categories/1/edit
  def edit
    @category = Category.find(params[:id])
		@category_attributes = @category.attrs + @category.ancestors_category_attributes
		@new_category_attributes = []
		2.times{ @new_category_attributes << @category.attrs.new() }
  end

  # POST /admin/categories
  # POST /admin/categories.xml
  def create
    @category = Category.new(params[:category])
		
    respond_to do |format|
      if @category.save
        flash[:notice] = I18n.t 'categories.created'
        format.html { redirect_to admin_categories_path }
        format.xml  { render :xml => @category, :status => :created, :location => @category }
      else
				(4 - @category.attrs.size).times { @category.attrs.build }
        format.html { render :action => "new" }
        format.xml  { render :xml => @category.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /admin/categories/1
  # PUT /admin/categories/1.xml
  def update
    @category = Category.find(params[:id])

    respond_to do |format|
      if @category.update_attributes(params[:category])
        flash[:notice] = I18n.t 'categories.updated'
        format.html { redirect_to edit_admin_category_path(@category) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @category.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /admin/categories/1
  # DELETE /admin/categories/1.xml
  def destroy
    @category = Category.find(params[:id])
    @category.destroy

		flash[:notice] = I18n.t 'categories.destroyed'
    respond_to do |format|
      format.html { redirect_to(admin_categories_path) }
      format.xml  { head :ok }
    end
  end

	private
	def find_root_categories
		@root_categories = Category.roots()
	end
end
