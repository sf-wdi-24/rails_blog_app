Rails.application.routes.draw do

  root "users#index"

  # renders the form on the page
  get '/signup'
  # receives the form and creates a user in the db
  post '/users'

  resources :users
end
