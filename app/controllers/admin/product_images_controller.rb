class Admin::ProductImagesController < AdminController
	
	def destroy
		@image = ProductImage.find(params[:id])
		@image.destroy
		
		respond_to do |format|
			format.html { redirect_to edit_admin_product_path(params[:product_id]) }
			format.xml {head :ok}
		end
	end
end