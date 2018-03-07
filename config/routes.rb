Rails.application.routes.draw do
  devise_for :managers
  resources :tours, only: [:show, :index]
  namespace :admin do
    resources :awards
    resources :companies
    resources :managers
    resources :booking_dates
    resources :tours
  end
  put   'booking_dates/signup/:id',       to: 'booking_dates#signup'
  patch 'booking_dates/signup/:id',       to: 'booking_dates#signup'
  put   'admin/booking_dates/signup/:id', to: 'admin/booking_dates#signup'
  patch 'admin/booking_dates/signup/:id', to: 'admin/booking_dates#signup'
  put   'admin/booking_dates/cancel/:id', to: 'admin/booking_dates#cancel'
  patch 'admin/booking_dates/cancel/:id', to: 'admin/booking_dates#cancel'
  root to: "tours#index"
  # default route for non-existent pages to avoid errors
  # get "*path" => 'tours#index'
  get '*path', to: redirect('/tours')
  put '*path', to: redirect('/tours')
  # patch '*', to: 'tours#index', to: redirect('/tours')
end
