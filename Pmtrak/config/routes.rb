Rails.application.routes.draw do
  resources :tickets, only: [:destroy, :edit, :update] do
    post 'book', on: :collection
  end
  resources :passengers do
    get 'my_trips', on: :member
    get 'user_reviews', on: :member
    get 'show_trains', on: :member
    get 'show_reviews', on: :member
    get 'display', on: :member
  end
  resources :reviews
  resources :trains do
    resources :reviews
    get 'train_reviews', on: :member
  end
  resources :tickets, only: [:edit]
  resources :admins, except: :index do
    get 'show_passengers', on: :member
    get 'show_trains', on: :member
    get 'show_tickets', on: :member
    get 'show_reviews', on: :member
    get 'show_train_customers', on: :member
  end
  get 'display', to: "admins#display", as: 'display_admin'
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
