class Admin::ProductImagesController < AdminController
	
	def destroy
		@image = ProductImage.find(params[:id])
		@image.destroy
		
		respond_to do |format|
			format.html { redirect_to edit_admin_product_path(params[:product_id]) }
			format.xml {head :ok}
		end
	end
	
	def edit
	  @product = Product.find(params[:product_id])
	  @product_image = ProductImage.find(params[:id]) 
	  respond_to do |format|
	    format.html { render 'admin/products/image_edit', :layout => false }
	    format.js { head :ok }
    end
  end
  
  def update
    @product_image = ProductImage.find(params[:id])
    
    respond_to do |format|
      if @product_image.update_attributes(params[:product_image])
        format.html { redirect_to edit_admin_product_path(@product_image.product)   }
        format.js   { head :ok }
      else
        format.html { render :action => :edit }
        format.js   { render :error => true }
      end
    end
  end
end