Rails.application.routes.draw do

  root to: 'users#index'
  resources :users

get '/login' => 'sessions#new'
post '/login' => 'sessions#create'
get '/logout' => 'sesions#destroy'

get '/users/new' => 'users#new'
post '/users' => 'users#create'

end
