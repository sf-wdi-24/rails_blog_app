Rails.application.routes.draw do
  
  root "posts#index"

  resources :posts

  get "/signup", to: "users#new"
  get "/login", to: "sessions#new"
  get "/logout", to: "sessions#destroy"

  resources :sessions, only: [:create]
  resources :users, except: [:new]

end
