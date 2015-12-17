Rails.application.routes.draw do


root to: "posts#index" #changed to go to posts instead of index  n
  
  get '/login' => 'sessions#new'
  post '/login' => 'sessions#create'
  get '/logout' => 'sessions#destroy'

  get '/signup' => 'users#new'
  post '/users' => 'users#create'

  resources :posts



end
