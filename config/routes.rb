Rails.application.routes.draw do

	root to: 'users#index'
	resources :users, except: [:new]

	get '/users/new' => 'users#new'
	get '/login' => 'sessions#new'
	get '/logout' => 'sessions#destroy'
	resources :sessions, only: [:create]

end
