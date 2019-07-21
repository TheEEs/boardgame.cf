Rails.application.routes.draw do
  post "orders/:id/approve" , to: "orders#approve", as: :approve_order
  resources :orders, except: [:new,:edit], constraints: {id: /[^\/]+/}
  #get 'order/:guid', to: "orders#show_by_guid", as: :order_guid
  get 'notifications', to: "notification#show", as: :notifications
  root "posts#index"
  get 'user/geosearch'
  get 'user/:id', to: "user#index", as: :user, constraints: {id: /[^\/]+/}
  post 'user/:id/follow', to: "user#follow", as: :follow_user
  post 'user/geolocation', as: :geolocation
  post 'posts/:id/like', to:'posts#like', as: :like_post
  
  resources :posts, except: [:new]
  resources :articles
  resources :games
  #devise_for :users
  devise_for :users, controllers: {
    registrations: 'users/registrations'
  }
  resources :tags, except: [:new]
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
