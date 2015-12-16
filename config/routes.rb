Rails.application.routes.draw do

  root "users#index"
  
  resources :users

  get '/signup' => 'users#new'

  get '/login' => 'session#new'
  post '/login' => 'session#create'
  get '/logout' => 'session#destroy'
end

#    Prefix Verb   URI Pattern               Controller#Action
#          root GET    /                         users#index
#     users GET    /users(.:format)          users#index
#           POST   /users(.:format)          users#create
#  new_user GET    /users/new(.:format)      users#new
# edit_user GET    /users/:id/edit(.:format) users#edit
#      user GET    /users/:id(.:format)      users#show
#           PATCH  /users/:id(.:format)      users#update
#           PUT    /users/:id(.:format)      users#update
#           DELETE /users/:id(.:format)      users#destroy
#    signup GET    /signup(.:format)         users#new
#     login GET    /login(.:format)          session#new
#           POST   /login(.:format)          session#create
#    logout GET    /logout(.:format)         session#destroy