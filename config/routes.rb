ActionController::Routing::Routes.draw do |map|
  map.resources :users
  map.resources :prayers
  map.resources :comments  
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
  
  # This is a catch-all for routes that don't exist, visitor is redirected to home page.
  ActionController::Routing::Routes.draw do |map|
      map.connect ':controller/:action/:id'
      map.connect '*path', :controller => 'error', :action => 'missing_page'
  end
  
  map.connect ':controller/:action/:id'
  map.connect ':controller/:action/:id.:format'
end
