Rails.application.routes.draw do

  root "posts#index"
  resources :posts do
    resources :comments
  end

  get "/signup", to: "users#new"
  get "/login", to: "sessions#new"
  get "/logout", to: "sessions#destroy"
  resources :sessions, only: [:create]

end