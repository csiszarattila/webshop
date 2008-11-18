class Admin::OrdersController < AdminController
	
	before_filter :find_order_states, :except => [:update]
	
  def index
		if params[:order_state]
			@state = OrderState.find(params[:order_state])
		else
			@state = OrderState.find_by_name("Újak")
		end
		@orders = @state.orders()
  end

  def show
		@order = Order.find(params[:id])
		@address = @order.address
  end

  def update
		@order = Order.find(params[:id])
		@order.update_attributes(params[:order])
		
		redirect_to admin_order_path(@order)
  end

	private
	def find_order_states
		@order_states = OrderState.all.collect{ |os| [os.name, os.id] }
	end
end
