class Admin::ProductsController < AdminController
	
	before_filter :find_root_categories, :only => [:index, :new, :edit, :update]
 
	# GET /admin/products
  # GET /admin/products.xml
  def index
		if params[:category]
			@category = Category.find(params[:category])
			@products = @category.products
		else
			@category = nil
			@products = Product.find(:all)
		end
		
    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @products }
    end
  end

  # GET /admin/products/new
  # GET /admin/products/new.xml
  def new
    @product = Product.new()
    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @product }
    end
  end

  # GET /admin/products/1/edit
  def edit
    @product = Product.find(params[:id])
  end

  # POST /admin/products
  # POST /admin/products.xml
  def create
    @product = Product.new(params[:product])

    respond_to do |format|
      if @product.save
        flash[:notice] = I18n.t 'products.created'
        format.html { redirect_to admin_products_path }
        format.xml  { render :xml => @product, :status => :created, :location => @product }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @product.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /admin/products/1
  # PUT /admin/products/1.xml
  def update
    @product = Product.find(params[:id])
    respond_to do |format|
      if @product.update_attributes(params[:product])
        flash[:notice] = I18n.t 'product.updated'
        format.html { redirect_to edit_admin_product_path(@product) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @product.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /admin/products/1
  # DELETE /admin/products/1.xml
  def destroy
    @product = Product.find(params[:id])
    @product.destroy

    respond_to do |format|
      format.html { redirect_to(admin_products_path) }
      format.xml  { head :ok }
    end
  end

	private
	def find_root_categories
		@root_categories = Category.roots()
	end
end
