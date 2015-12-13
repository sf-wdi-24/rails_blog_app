Rails.application.routes.draw do

  root "posts#index"
  resources :posts
  resources :users, except: [:new]

  get "/signup", to: "users#new"
  get "/login", to: "sessions#new"
  get "/logout", to: "sessions#destroy"
  resources :sessions, only: [:create]

end