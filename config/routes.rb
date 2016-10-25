Rails.application.routes.draw do
  resources :apartment_lists
  resources :apartments
  devise_for :users
  resources :users
  # resources :users, only: [:show] do
  #   resources :lists
  # end

  # get '/' => 'apartments#home_page'
  get '/' => 'apartments#home_page'
  post '/apartments/list' => 'apartments#list'
  get '/home' => 'users#index'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
