Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      
      post '/login', to: 'sessions#login'
      get '/autologin', to: 'sessions#autologin'

      resources :orders, only: [:create, :destroy]
      get '/user-orders', to: 'orders#user_orders'
      post '/place-order', to: 'orders#place_order'
      
      resources :products, only: [:create, :update, :index, :show, :destroy]
      get '/products_by', to: 'products#filter_products'
      
      resources :users, only: [:index]
      post '/signup', to: 'users#create'
    end
  end
end
