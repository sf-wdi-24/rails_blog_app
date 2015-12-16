Rails.application.routes.draw do

	root to: 'users#index'

	get 'password_resets/new'
	get '/login' => 'sessions#new'
	post '/login' => 'sessions#create'
	get '/logout' => 'sessions#destroy'
	get '/signup' => 'users#new'
	post '/users' => 'users#create'
	delete '/users/1/edit' => 'users#destroy', :as => "destroy_user"

	resources :users
	resources :sessions
	resources :password_resets

end
