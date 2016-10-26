Rails.application.routes.draw do


  devise_for :users, :controllers => { :omniauth_callbacks => "users/omniauth_callbacks" }

  # devise_scope :user do
  #   get '/users/sign_out' => 'devise/sessions#destroy'
  # end

  # resources :users
  resources :apartment_lists
  resources :apartments



  resources :apartment_lists

  resources :apartments
  # get "/users/:id/lists/:lists_id" => "lists#index"
    root "users#index"
  # devise_for :users
  resources :lists

  resources :users do
    resources :lists
  end
  patch "/users/:user_id/lists/add_to_list" => "lists#add_to_list", as: "update_lists"


  # get '/' => 'apartments#home_page'
  # get '/' => 'apartments#home_page'
  # post '/apartments/list' => 'apartments#list'
  # get '/' => 'users#index'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
