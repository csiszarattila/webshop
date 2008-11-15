class OrderController < ApplicationController
	
	before_filter :authorize_as_customer
	before_filter :find_cart, :only => [:confirm, :create]
		
	def create
		@order = session[:order]
		@address = session[:address]
		
		@address.addressable = @order
		@address.save
		
		@order.add_items_from_cart(@cart)
		@order.customer = @customer
		@order.save
		
		destroy_cart()
	end
	
	def address
		@order_types = OrderType.all()
		
		if session[:order]
			@order = session[:order]
			@address = session[:address]
			session[:order] = nil
			session[:address] = nil
			
		elsif params[:order]
			@order = Order.new(params[:order])
			@address = Address.new(params[:address])
			
			@address.valid? # otherwise errors dont added because of if condition
			if @order.valid? and @address.valid?
				# Save the address if the customer haven't got one
				# A címet mindenképp elmentjük, ha még nincs a vásárlónak
				if @customer.address.nil?
					address = Address.new(params[:address])
					address.addressable = @customer
					address.save
				end
				# store order and address in session until checkout
				# a rendelesi adatokat es cimet session-be mentjük a rendeles befejezeséig
				session[:order] = @order
				session[:address] = @address
				redirect_to order_confirm_path and return
			end
			
		else
			@order = Order.new()
			@address = @customer.address || Address.new()
		end
	end
	
	def confirm
		redirect_to order_address_path and return unless session[:order]
		@cart
	end
end
