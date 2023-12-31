Rails.application.routes.draw do
  resources :payrolls
  resources :contribution_rates
  resources :payroll_items
  resources :paychecks
  resources :hours
  resources :rates
  resources :rate_amounts
  resources :rate_classifications
  resources :employee_classifications
  resources :time_periods
  namespace :admin do
      resources :users

      root to: "users#index"
    end
  resources :employees
  get 'employees/generate_paperwork/:id' => 'employees#generate_paperwork_form', :as => 'generate_paperwork_form'
  post 'employees/generate_paperwork/:id' => 'employees#generate_paperwork', :as => 'generate_paperwork'

  devise_for :users
  get 'home/index'

  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
  root "home#index"
end
