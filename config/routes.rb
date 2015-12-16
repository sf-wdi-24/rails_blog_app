Rails.application.routes.draw do
  root 'bikes#index'

  resources :bikes

# route sends request to our url
  root to: 'bikes#user'

#these routes are for showing users
  get '/login' => 'session#new'
  post '/login' => 'sessions#create'
  get '/logout' => 'sessions#destroy'

  get '/new' => 'bikes#new'

  get '/signup' => 'users#new'
  post '/users' => 'users#create'

end
