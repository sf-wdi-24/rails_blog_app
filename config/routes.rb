Rails.application.routes.draw do
  root 'posts#index'

  resources :posts do
    resources :comments, except:[:index, :show]
  end
  resources :users, except:[:new]

  #user actions
  get '/signup' => 'users#new'
  post '/users' => 'users#create'

  #session actions
  get 'login' => 'sessions#new'
  post 'login' => 'sessions#create'
  get 'logout' => 'sessions#destroy'

end
