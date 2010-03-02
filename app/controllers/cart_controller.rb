class CartController < ApplicationController
	before_filter :find_cart, :except => [:empty]
	skip_before_filter :show_cart
	
	def index
	end
	
	def add
		product = Product.find(params[:id])
		item = @cart.add_product(product)
	
		respond_to do |format|
		  format.html { redirect_to :action => 'index' }
		  format.js   { render :json => { 
		        :item => { 
		          :quantity => item.quantity(), 
		          :price => item.price() 
		        }, 
		        :total_price => @cart.total_price 
		      }
		  }
	  end
	  
	rescue ActiveRecord::RecordNotFound
		logger.error("Olyan terméket akartak elhelyezni a kosárban amely nem nem létezik. ID: #{params[:id]}")
		redirect_to :root
	end
	
	def remove
		item = @cart.remove_product(params[:id])
		
    respond_to do |format|
      format.html { 
        redirect_to :action => 'empty' and return if @cart.items.empty?
        redirect_to :action => 'index'
      }
      format.js   { render :json => { 
		        :item => { 
		          :quantity => item.quantity(), 
		          :price => item.price() 
		        }, 
		        :total_price => @cart.total_price 
		      }
		  }
    end
		
	rescue ActiveRecord::RecordNotFound
		logger.error("Olyan terméket akartak kivenni a kosárból amely benne sem volt. ID: #{params[:id]}")
		redirect_to :root
	end
	
	def destroy
		@cart.destroy_item(params[:id])
		
		redirect_to :action => 'empty' and return if @cart.items.empty? 
		
		flash[:notice] = I18n.t('cart.item.destroyed')
		redirect_to :action => 'index'
		
	rescue ActiveRecord::RecordNotFound
		logger.error("Olyan terméket akartak törölni a kosárból amely benne sem volt. ID: #{params[:id]}")
		redirect_to :root
	end
	
	def empty
		session[:cart] = nil
		flash[:notice] = I18n.t('cart.emptied')
		redirect_to root_path
	end
	
	private
	def find_cart
		@cart = (session[:cart] ||= Cart.new)
	end
end
