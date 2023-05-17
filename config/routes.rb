Rails.application.routes.draw do
  devise_for :users
  resources :users, only: %i[show edit update]
  resources :events
  root to: "events#index"
end
