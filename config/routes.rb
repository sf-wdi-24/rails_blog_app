Rails.application.routes.draw do

  get 'posts/index'

  get 'posts/new'

  get 'posts/create'

  get 'posts/show'

  get 'posts/edit'

  get 'posts/update'

  get 'posts/destroy'

  root "users#index"
  resources :users
end
