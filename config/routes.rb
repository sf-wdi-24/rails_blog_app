Rails.application.routes.draw do
  root "bikes#index"

  resources :bikes
  
end
