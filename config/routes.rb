Rails.application.routes.draw do
  resources :apartment_lists
  resources :lists
  devise_for :users
  resources :users
  resources :apartments
  resources :jets
  resources :amazons
  resources :ebays
  get '/home' => 'users#index'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
