ActionController::Routing::Routes.draw do |map|
  # The priority is based upon order of creation: first created -> highest priority.

  # Sample of regular route:
  #   map.connect 'products/:id', :controller => 'catalog', :action => 'view'
  # Keep in mind you can assign values other than :controller and :action

  # Sample of named route:
  #   map.purchase 'products/:id/purchase', :controller => 'catalog', :action => 'purchase'
  # This route can be invoked with purchase_url(:id => product.id)

  # Sample resource route (maps HTTP verbs to controller actions automatically):
  #   map.resources :products

  # Sample resource route with o	ptions:
  #   map.resources :products, :member => { :short => :get, :toggle => :post }, :collection => { :sold => :get }

  # Sample resource route with sub-resources:
  #   map.resources :products, :has_many => [ :comments, :sales ], :has_one => :seller
  
  # Sample resource route with more complex sub-resources
  #   map.resources :products do |products|
  #     products.resources :comments
  #     products.resources :sales, :collection => { :recent => :get }
  #   end

  # Sample resource route within a namespace:
  #   map.namespace :admin do |admin|
  #     # Directs /admin/products/* to Admin::ProductsController (app/controllers/admin/products_controller.rb)
  #     admin.resources :products
  #   end

	map.resources :categories
	map.resources :products
	
	map.admin_root '/admin/', :controller => 'admin', :action => 'index'
	map.namespace :admin do |admin|
		admin.resources	:orders
		admin.resources :categories, :has_many => [ :category_attributes ]
		admin.resources :products, :has_many => [ :product_images ]
	end
	
	map.with_options :controller => "cart" do |cart|
		cart.show_cart 'cart', :action => 'index'
		cart.add_to_cart 'cart/add/:id', :action => 'add'
		cart.remove_from_cart 'cart/remove/:id', :action => 'remove'
		cart.destroy_cart_item 'cart/destroy/:id', :action => 'destroy'
		cart.empty_cart 'cart/empty', :action => 'empty'
	end
	
	map.with_options :controller => "user" do |user|
		user.login_or_registration 'user/login_or_registration/', :action => 'login_or_registration'
		user.login 'user/login/', :action => 'login'
		user.registration 'user/registration/', :action => 'registration'
		user.password_remember 'user/password_remember/', :action => 'password_remember'
		user.logout	'user/logout/', :action => 'logout'
		user.user_show 'user/show', :action => 'show'
		user.user_edit 'user/edit', :action => 'edit'
		user.admin_login 'admin/login', :action => 'admin_login'
	end
	
	map.with_options :controller => "order" do |order|
		order.order_address 'order/address', :action => 'address'
		order.order_confirm 'order/confirm', :action => 'confirm'
		order.create_order 'order/create', :action => 'create'
	end

  # You can have the root of your site routed with map.root -- just remember to delete public/index.html.
  map.root :controller => "main"
	map.search 'search/', :controller => "main", :action => "search"

  # Install the default routes as the lowest priority.
  # Note: These default routes make all actions in every controller accessible via GET requests. You should
  # consider removing the them or commenting them out if you're using named routes and resources.
  map.connect ':controller/:action/:id'
  map.connect ':controller/:action/:id.:format'
end