class Admin::CategoryAttributesController < AdminController
	
	def edit
		@category = Category.find(params[:category_id])
		@attribute = CategoryAttribute.find(params[:id])
	end
	
	def update
		@attribute = CategoryAttribute.find(params[:id])
		@category = @attribute.category
		if @attribute.update_attributes(params[:category_attribute])
			redirect_to edit_admin_category_path(@category)
		else
			render :action => "edit"
		end
	end
	
	def destroy
		@attribute = CategoryAttribute.find(params[:id])
		@attribute.destroy
		redirect_to back()
	end
end
