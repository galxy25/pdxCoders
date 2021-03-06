Rails.application.routes.draw do
  root 'homepage#index'
  get 'homepage/index'
  get '/stats' => 'homepage#stats'

  devise_for :users, :controllers => { :omniauth_callbacks => "omniauth_callbacks"}
  get 'sessions/new'

  post 'homepage/subscribe_email', to: 'homepage#subscribe_email'

  get    'profile' => 'users#edit'
  get    'signup'  => 'users#new'
  get    'login'   => 'sessions#new'
  get    'cardcreator' => 'cards#new'
  post   'cardcreator' => 'cards#create'
  post   'login'   => 'sessions#create'
  delete 'logout'  => 'sessions#destroy'
  post   'playlist/edit' => 'playlist#edit'

  resources :users,  only: [:index, :show, :create, :edit, :update]
  get 'users/:id/playlists' => 'users#playlists'

  resources :cards do
    collection do 
      post :import 
      post :examples 
    end

    member do
      post :examples 
    end
  end

  resources :playlists do
    member do
      post :remove_card_playlist
    end
  end

  resources :playlists
  put 'playlists/:id/add_card/:card_id' => 'playlists#add_card'

  get 'playlists/:id/cards' => 'playlists#cards'

  # API Routes
  namespace :api do
      # Because nothing is ever perfect the first time...
      scope '/v1' do
          post   'login'  => 'api#login'
          delete 'logout' => 'api#logout'

          resources :cards 
          resources :users
      end
  end
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
