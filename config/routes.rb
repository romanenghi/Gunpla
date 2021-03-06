Gundam::Application.routes.draw do
  get "import/import"
  match '/upload', :to => 'import#upload'
  match '/parse', :to => 'import#parse'
  resources :gunplatypes
  resources :gunplas
  match '/cosmicimport', :to => 'gunplas#cosmicimport'
  match '/export', :to => 'gunplas#export'
  match '/getHljData', :to => 'gunplas#importHljData'
  match '/get1999Data', :to => 'gunplas#import1999Data'
  match '/getReadyData', :to => 'gunplas#importReady'
  match '/ready', :to => 'gunplas#ready'
  match '/crop', :to => 'imagetool#crop'
  match '/exportCVS', :to => 'gunplas#exportCVS'
  match '/getnewimage', :to => 'gunplas#getnewimage'
  match '/categories', :to => 'gunplas#categories'
  match '/getcategories', :to => 'gunplas#getcategories'
  match '/deleteimage', :to => 'gunplas#deleteimage'
  match '/googleimage', :to => 'gunplas#googleimage'
  match '/utility', :to => 'utility#index'
  match '/gunplahome', :to => 'utility#gunplahome'
  match '/type', :to => 'gunplatypes#index'
  match '/gunplascalas', :to => 'gunplas#gunplascalas'
  match '/getgunplascalas', :to => 'gunplas#getgunplascalas'
  match '/gunplamodeltypes', :to => 'gunplas#gunplamodeltypes'
  match '/getgunplamodeltypes', :to => 'gunplas#getgunplamodeltypes'
  root :to => 'gunplas#index'
  
end
  # The priority is based upon order of creation:
  # first created -> highest priority.

  # Sample of regular route:
  #   match 'products/:id' => 'catalog#view'
  # Keep in mind you can assign values other than :controller and :action

  # Sample of named route:
  #   match 'products/:id/purchase' => 'catalog#purchase', :as => :purchase
  # This route can be invoked with purchase_url(:id => product.id)

  # Sample resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Sample resource route with options:
  #   resources :products do
  #     member do
  #       get 'short'
  #       post 'toggle'
  #     end
  #
  #     collection do
  #       get 'sold'
  #     end
  #   end

  # Sample resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Sample resource route with more complex sub-resources
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', :on => :collection
  #     end
  #   end

  # Sample resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end

  # You can have the root of your site routed with "root"
  # just remember to delete public/index.html.
  # root :to => 'welcome#index'

  # See how all your routes lay out with "rake routes"

  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.
  # match ':controller(/:action(/:id(.:format)))'

