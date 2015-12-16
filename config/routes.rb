Rails.application.routes.draw do
  
  root 'users#index'

  get '/login' => 'sessions#new'
  post '/login' => 'sessions#create'
  get '/logout' => 'sessions#destroy'

  resources :users

  

end
