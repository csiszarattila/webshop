class CartController < ApplicationController
	before_filter :find_cart, :except => [:empty]
	skip_filter :show_cart
	
	def index
	end
	
	def add
		product = Product.find(params[:id])
		@cart.add_product(product)
		redirect_to :action => 'index'
	end
	
	def remove
		@cart.remove_product(params[:id])
		
		redirect_to :action => 'empty' and return if @cart.items.empty?
		
		redirect_to :action => 'index'
	end
	
	def destroy
		@cart.destroy_item(params[:id])
		
		redirect_to :action => 'empty' and return if @cart.items.empty? 
		
		flash[:notice] = I18n.t('cart.item.destroyed')
		redirect_to :action => 'index'
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
