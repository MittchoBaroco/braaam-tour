Rails.application.routes.draw do
  devise_for :managers
  resources :tours, only: [:show, :index]
  put 'booking_dates/commit/:id',   to: 'booking_dates#commit'
  patch 'booking_dates/commit/:id', to: 'booking_dates#commit'
  namespace :admin do
    resources :awards
    resources :companies
    resources :managers
    resources :booking_dates
    resources :tours
  end
  root to: "tours#index"
  # default route for non-existent pages to avoid errors
  # get "*path" => 'tours#index'
  get '*path', to: redirect('/tours')
  put '*path', to: redirect('/tours')
  # patch '*', to: 'tours#index', to: redirect('/tours')
end
