Rails.application.routes.draw do
  root 'bikes#index'

  resources :bikes

#these routes are for showing users
  get '/login' => 'sessions#new'
  post '/login' => 'sessions#create'
  get '/logout' => 'sessions#destroy'

  get '/signup' => 'users#new'
  post '/users' => 'users#create'

end
