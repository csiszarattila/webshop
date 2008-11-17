class OrderController < ApplicationController
	
	before_filter :authorize_as_customer
	before_filter :find_cart, :only => [:confirm, :create]
		
	def create
		redirect_to :root and return unless session[:order] or session[:address]
		@order = session[:order]
		@address = session[:address]
		
		@order.add_items_from_cart(@cart)
		@order.customer = @customer
		@order.save
		
		@address.addressable = @order
		@address.save
		
		destroy_cart()
		session[:order], session[:address] = nil
	end
	
	def address
		@order_types = OrderType.all()
		
		# kitöltött	form adatainak ellenőrzése, 
		# adatok mentése sessionbe
		if params[:order]
			@order = Order.new(params[:order])
			@address = Address.new(params[:address])
			
			@address.valid? # az if miatt, maskülönben nem adná hozzá a hibaüzeneteket
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
		# a sessionben már vannak adatok
		# a vásárló már kitöltötte elküldte a formot korábban
		elsif session[:order]
			@order = session[:order]
			@address = session[:address]
		# Első kitöltés	
		else
			@order = Order.new()
			@address = @customer.address || Address.new()
		end
	end
	
	def confirm
		redirect_to order_address_path and return unless session[:order]
	end
end
