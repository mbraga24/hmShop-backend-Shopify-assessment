Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      
      post '/login', to: 'sessions#login'
      get '/autologin', to: 'sessions#autologin'

      resources :orders
      
      resources :products
      
      resources :users, only: [:index]
      post '/signup', to: 'users#create'
    end
  end
end
