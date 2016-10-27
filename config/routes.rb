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

  resources :lists

  resources :users do
    resources :lists
  end

  post '/users/location/:location_id' => "users#location"
  post "/users/:user_id/lists/add_to_list" => "lists#add_to_list", as: "update_lists"
  get "/users/:id/lists/:lists_id" => "lists#index"
  root "users#index"


  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
