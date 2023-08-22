Rails.application.routes.draw do
  namespace :admin do
      resources :users

      root to: "users#index"
    end
  resources :employees
  devise_for :users
  get 'home/index'
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
  root "home#index"
end
