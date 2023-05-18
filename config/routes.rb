Rails.application.routes.draw do
  resources :comments, only: %i[ create destroy ]
  devise_for :users
  resources :users, only: %i[ show edit update ]
  resources :events

  root to: "events#index"
end
