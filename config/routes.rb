Rails.application.routes.draw do
  root 'bikes#index'

  resources :bikes

#these routes are for showing users
  get '/login' => 'sessions#new'
  post '/login' => 'sessions#create'
  get '/logout' => 'sessions#destroy'

  get '/signup' => 'users#new'
  post '/users' => 'users#create'

end

#    Prefix Verb   URI Pattern               Controller#Action
#      root GET    /                         bikes#index
#     bikes GET    /bikes(.:format)          bikes#index
#           POST   /bikes(.:format)          bikes#create
#  new_bike GET    /bikes/new(.:format)      bikes#new
# edit_bike GET    /bikes/:id/edit(.:format) bikes#edit
#      bike GET    /bikes/:id(.:format)      bikes#show
#           PATCH  /bikes/:id(.:format)      bikes#update
#           PUT    /bikes/:id(.:format)      bikes#update
#           DELETE /bikes/:id(.:format)      bikes#destroy
#     login GET    /login(.:format)          sessions#new
#           POST   /login(.:format)          sessions#create
#    logout GET    /logout(.:format)         sessions#destroy
#    signup GET    /signup(.:format)         users#new
#     users POST   /users(.:format)          users#create