Rails.application.routes.draw do

  get 'sessions/new'

  get 'sessions/create'

  get 'sessions/destroy'

  root to: 'users#index'

  resources :users

  # Signup Routes
  get '/signup' => 'users#new'
  post '/signup' => 'users#create'

  # Login Routes
  get '/login' => 'sessions#new'
  post '/login' => 'sessions#create'
  get '/logout' => 'sessions#destroy'
  
end