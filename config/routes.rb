Rails.application.routes.draw do
  resources :apartment_lists
  resources :apartments
  devise_for :users, only:[:show]

  resources :users, only: [:show] do
    resources :lists
  end

  get '/' => 'apartments#home_page'
  post '/apartments/list' => 'apartments#list'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
