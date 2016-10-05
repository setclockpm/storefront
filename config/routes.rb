Porthos::Application.routes.draw do
  get 'contact', to: 'messages#new', as: 'contact'
  post 'contact', to: 'messages#create'
  

  mount Spree::Core::Engine, at: '/store'
  
  # Disable this when app is finished. Admin route should be obfuscated from general public
  get '/admin', to: 'spree/admin/orders#index', as: :admin
  get "/about_us", to: "storefront#about", as: :about
  get "/collection", to: "collection#index", as: :collection
  
  # mount Spree::Core::Engine, at: '/'  # The priority is based upon order of creation:
  # first created -> highest priority.
  
  Spree::Core::Engine.routes.draw do
    namespace :admin do
      get "products/data_import" => "products#data", as: :data_import
      get "showcase_items" => "showcase_items#index", as: :showcase
      post "import/inventory" => "products#bulk_import", as: :import_inventory
      post "import/variant_photos" => "products#import_images", as: :generate_variant_photos
      # This adds a method to products called "add_to_cart" to the member (individual resource). If you run 
      # rake routes in your console you'll see it requires an id #=> /products/:id/add_to_cart
      #get 'variants/on_hand' => 'products#count_on_hand', as: :count_on_hand
      resources :showcase_items
    end
  end

  # Sample of regular route:
  #   match 'products/:id' => 'catalog#view'
  # Keep in mind you can assign values other than :controller and :action

  # Sample of named route:
  #   match 'products/:id/purchase' => 'catalog#purchase', :as => :purchase
  # This route can be invoked with purchase_url(:id => product.id)
  #get "admin" => "storefront/admin/order#index", as: :admin
  
  # Sample resource route (maps HTTP verbs to controller actions automatically):
  resources :customers, only: [:index]
  resources :products, only: [] do
    get :count_on_hand, on: :member
  end
  
  get "storefront/catalog" => "storefront#catalog", as: :download_catalog

  # Sample resource route with options:
  #   resources :products do
  #     member do
  #       get 'short',
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
  root to: 'storefront#index'

  # See how all your routes lay out with "rake routes"

  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.
  # match ':controller(/:action(/:id))(.:format)'
end
