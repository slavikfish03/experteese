Rails.application.routes.draw do
  get "up" => "rails/health#show", as: :rails_health_check

  root "main#index"

  get "help", to: "main#help"
  get "about", to: "main#about"
  get "contacts", to: "main#contacts"
  get "work", to: "work#index"
  get "signup", to: "users#new"
  get "login", to: "sessions#new"
  post "login", to: "sessions#create"
  delete "logout", to: "sessions#destroy"

  resources :users, only: [ :show, :new, :create ]
  resources :values, only: [ :create ]

  namespace :api do
    get "next_image", to: "api#next_image"
    get "prev_image", to: "api#prev_image"
  end
end
