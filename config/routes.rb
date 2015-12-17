Rails.application.routes.draw do

	root to: 'posts#index'
	resources :posts
	get '/users/new' => 'users#new'
	resources :users, except: [:new]

	get '/login' => 'sessions#new'
	get '/logout' => 'sessions#destroy'
	resources :sessions, only: [:create]

end
