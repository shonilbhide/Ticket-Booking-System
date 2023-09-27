Rails.application.routes.draw do
  resources :tickets
  resources :passengers
  resources :reviews
  resources :trains
  resources :admins
  resources :products
  resources :credit_cards
  resources :transactions
  root 'home#index'
  resources :sessions, only: [:new, :create, :destroy]
  get 'signup', to: "passengers#new", as: 'signup'
  get 'login', to: "sessions#new", as: 'login'
  get 'logout', to: "sessions#destroy", as: 'logout'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
