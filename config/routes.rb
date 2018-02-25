Rails.application.routes.draw do
  resources :tours, only: [:show, :index]
end
