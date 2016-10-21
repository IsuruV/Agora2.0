Rails.application.routes.draw do
  resources :users
  resources :apartments
  resources :jets
  resources :amazons
  resources :ebays
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
