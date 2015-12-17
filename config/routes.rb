Rails.application.routes.draw do

	root to: 'posts#index'

	get '/login' => 'sessions#new'
	post '/login' => 'sessions#create'
	get '/logout' => 'sessions#destroy'
	get '/signup' => 'users#new'
	post '/users' => 'users#create'
	delete '/users/settings' => 'users#destroy', :as => "destroy_user"
	delete '/posts/settings' => 'posts#destroy', :as => "destroy_post"
	get 'users/:id/posts' => 'users#show_user_posts', :as => "show_user_posts"
	get 'posts/:id/edit' => 'posts#edit'
	get 'users/settings' => 'users#edit'


	resources :users, :except => [:edit]
	resources :posts, :except => [:edit]
	resources :sessions
	resources :password_resets

end
