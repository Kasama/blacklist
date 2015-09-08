Rails.application.routes.draw do

  root to: 'app#index'

  # User related pages
  get 'sign_up' => 'users#new', as: 'sign_up' # creates a new user (ADMIN ONLY)
  get 'login' => 'sessions#new', as: 'login' # login with existing user (ANYONE)
  get 'logout' => 'sessions#destroy', as: 'logout' # log out of a existing session (USERS ONLY)
  get 'change_password' => 'users#modify', as: 'change_password' # change password of a existing user (USERS ONLY)
  match 'edit_pass', controller: 'users', action: 'change_password', via: :post

  # List related pages
  get 'list' => 'entries#list', as: 'list' # list all entries or find some (USERS ONLY)
  get 'show/:id' => 'entries#show', as: 'show' # show details of an entry (USERS ONLY)
  get 'delete/:id' => 'entries#destroy', as: 'delete' # remove an entry (ADMIN ONLY)
  get 'new_entry' => 'entries#new', as: 'new_entry' # add a new entry (USERS ONLY)

  resource :users
  resource :sessions
  resource :entries

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
