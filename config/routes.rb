Rails.application.routes.draw do

  root "users#index"
  resources :users, except: [:new]

  get "/signup", to: "users#new"
  get "/login", to: "sessions#new"
  resources :sessions, only: [:create, :destroy]

end