ActionController::Routing::Routes.draw do |map|

map.login '/login' , :controller => "user_sessions", :action => "new"

map.logout '/logout' , :controller => "user_sessions", :action => "destroy"
map.register '/register' , :controller => "users", :action => "new"

map.resources :users
map.resource :user_session
map.resource :account, :controller => "users"


map.resources :questions , :member => {:vote => :post , :tag => :get} ,
                           :collection => {:unanswered => :get} do |question|
  question.resources :answers
  question.resources :flags
end

map.resources :answers, :member => {:vote => :post , :select => :post} do |answer|
  answer.resources :comments
  answer.resources :flags
end

map.resources :search , :controller => 'search'

#map.resources :comments do |comment|
#  comment.resources :flags
#end



# == Admin Namespace

map.namespace :admin do |admin|
  admin.resource :dashboard , :controller => :dashboard
  admin.resources :questions , :member => {:ban => :post}
  admin.resources :answers , :member => {:ban => :post}
  admin.resources :users , :member => {:ban => :post}
end


map.root :controller => "home", :action => "index"
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

  # You can have the root of your site routed with map.root -- just remember to delete public/index.html.
  # map.root :controller => "welcome"

  # See how all your routes lay out with "rake routes"

  # Install the default routes as the lowest priority.
  # Note: These default routes make all actions in every controller accessible via GET requests. You should
  # consider removing the them or commenting them out if you're using named routes and resources.
  map.connect ':controller/:action/:id'
  map.connect ':controller/:action/:id.:format'
end
