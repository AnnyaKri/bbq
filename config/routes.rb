Rails.application.routes.draw do
  resources :users, only: %i[show edit update]
  resources :events
  root to: "events#index"
end
