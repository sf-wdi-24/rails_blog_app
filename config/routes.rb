Rails.application.routes.draw do

 root to: "posts#index"
	  
  resources :users
  resources :posts


  get '/signup' => 'users#new'

  get '/login' => 'session#new'
  post '/login' => 'session#create'
  get '/logout' => 'session#destroy'
end
