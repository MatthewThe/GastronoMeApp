Rails.application.routes.draw do
  root to: 'reviews#index'
  
  get 'reviews/tag/:tag' => 'reviews#index', as: :review_tag
  get 'restaurants/tag/:tag' => 'restaurants#index', as: :restaurant_tag
  get 'restaurants/search/:search' => 'restaurants#index', as: :restaurant_search
  get 'map' => 'restaurants#index', as: :map, :mode => "map"
  get 'map/search/:search' => 'restaurants#index', as: :map_search, :mode => "map"
  get 'map/tag/:tag' => 'restaurants#index', as: :map_tag, :mode => "map"
  get 'map/restaurant/:id' => 'restaurants#show', as: :map_restaurant, :mode => "map"
  
  resources :reviews, :restaurants, :users
  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  # root 'welcome#index'

  # Example of regular route:
  #   get 'products/:id' => 'catalog#view'

  # Example of named route that can be invoked with purchase_url(id: product.id)
  #   get 'products/:id/purchase' => 'catalog#purchase', as: :purchase

  # Example resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Example resource route with options:
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

  # Example resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Example resource route with more complex sub-resources:
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', on: :collection
  #     end
  #   end

  # Example resource route with concerns:
  #   concern :toggleable do
  #     post 'toggle'
  #   end
  #   resources :posts, concerns: :toggleable
  #   resources :photos, concerns: :toggleable

  # Example resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end
end
