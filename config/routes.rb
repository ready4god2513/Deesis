ActionController::Routing::Routes.draw do |map|
  map.resources :users
  map.resources :prayers
  map.resources :comments
  map.resources :articles
  map.resources :user_sessions
  
  map.root :controller => 'prayers'
  map.post 'post', :controller => 'prayers', :action => 'new'
  map.commit 'commit/:id', :controller => 'prayers', :action => 'commit'
  map.community 'community.:format', :controller => 'users', :action => 'index'
  map.login 'login', :controller => 'user_sessions', :action => 'new'
  map.logout 'logout', :controller => 'user_sessions', :action => 'destroy'
  map.register 'register', :controller => 'users', :action => 'new'
  map.profile 'profile/:username.:format', :controller => 'users', :action => 'show'
  map.account 'account', :controller => 'users', :action => 'edit'
  map.activity 'activity/:username.:format', :controller => 'users', :action => 'activity'
  map.answered 'prayers/answered/:id.:format', :controller => 'prayers', :action => 'answered'

  # The priority is based upon order of creation: first created -> highest priority.

  # Sample of regular route:
  #   map.connect 'products/:id', :controller => 'catalog', :action => 'view'
  # Keep in mind you can assign values other than :controller and :action

  # Sample of named route:
  #   map.purchase 'products/:id/purchase', :controller => 'catalog', :action => 'purchase'
  # This route can be invoked with purchase_url(:id => product.id)

  # Sample resource route (maps HTTP verbs to controller actions automatically):
  #   map.resources :products

  # Sample resource route with options:
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
  
  # This is a catch-all for routes that don't exist, visitor is redirected to home page.
  ActionController::Routing::Routes.draw do |map|
      map.connect ':controller/:action/:id'
      map.connect '*path', :controller => 'error', :action => 'missing_page'
  end

  # You can have the root of your site routed with map.root -- just remember to delete public/index.html.
  # map.root :controller => "welcome"

  # See how all your routes lay out with "rake routes"

  # Install the default routes as the lowest priority.
  # Note: These default routes make all actions in every controller accessible via GET requests. You should
  # consider removing or commenting them out if you're using named routes and resources.
  map.connect ':controller/:action/:id'
  map.connect ':controller/:action/:id.:format'
end
