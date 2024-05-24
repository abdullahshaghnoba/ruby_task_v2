Rails.application.routes.draw do
  # Devise routes for authors
  devise_for :authors, controllers: {
    registrations: 'authors/registrations'
  }

  # Resource routes for authors and books
  resources :authors, only: [:show]
  resources :books
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  root 'home#index'

  # Defines the root path route ("/")
  # root "posts#index"
end
