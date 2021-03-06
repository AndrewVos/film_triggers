Rails.application.routes.draw do
  devise_for :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  root to: 'movies#index'

  resources :movies, only: %i(index show)

  resources :triggers, only: %i(create)
end
