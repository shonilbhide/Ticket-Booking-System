Rails.application.routes.draw do
  resources :tickets
  resources :passengers
  resources :reviews
  resources :trains
  resources :admins
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
