Rails.application.routes.draw do
  devise_for :managers
  resources :tours, only: [:show, :index]
  namespace :admin do
    resources :awards
    resources :companies
    resources :managers
    resources :tour_dates
    resources :tours
  end
  root to: "tours#index"
end
