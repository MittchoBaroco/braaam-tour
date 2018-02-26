Rails.application.routes.draw do
  devise_for :managers
  resources :tours, only: [:show, :index]
  root to: "tours#index"
end
