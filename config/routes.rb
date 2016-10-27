Rails.application.routes.draw do

    get "/users/:id/lists/:lists_id" => "lists#index"
    
  devise_for :users, :controllers => { :omniauth_callbacks => "users/omniauth_callbacks" }

  # devise_scope :user do
  #   get '/users/sign_out' => 'devise/sessions#destroy'
  # end

  # resources :users
  resources :apartment_lists
  resources :apartments



  resources :apartment_lists

  resources :apartments

  resources :lists

  resources :users do
    resources :lists
  end

  post '/users/location/:location_id' => "users#location"

  post "/users/:user_id/lists/add_to_list" => "lists#add_to_list", as: "update_lists"
  get "/list/:list_id/delete_list" => "lists#delete_list", as: "delete_list"
  get "/lists/:list_id/apartments/:apartment_id/delete_apartment_from_list" => "lists#delete_apartment_from_list", as:"delete_apartment_from_list"
  root "users#index"


  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
