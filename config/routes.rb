Rails.application.routes.draw do

  root to: 'posts#index'

  resources :users
  resources :posts

  # Session Routes
  get 'sessions/new'
  get 'sessions/create'
  get 'sessions/destroy'

  # Signup Routes
  get '/signup' => 'users#new'
  post '/signup' => 'users#create'

  # Login Routes
  get '/login' => 'sessions#new'
  post '/login' => 'sessions#create'
  get '/logout' => 'sessions#destroy'
  
end