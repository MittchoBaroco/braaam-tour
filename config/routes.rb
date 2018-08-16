Rails.application.routes.draw do
  devise_for :companies
  devise_for :managers

  resources :tours, only: [:show, :index, :new, :edit, :create, :update] do
    resources :comments, only: [:create]
  end
  resources :companies, only: [:update]

  namespace :admin do
    resources :companies
    resources :managers
    resources :tours
    # admin dashboard root page (admin_tours)
    root to: "tours#index"
  end
  get   'companies/:id/bookings',         to: 'companies#bookings', as: "company_bookings"
  get   'companies/:id/settings',         to: 'companies#settings', as: "company_settings"
  get   'companies/:id/tours',            to: 'companies#tours', as: "company_tours"
  get   'booking_dates/book/:id',         to: 'booking_dates#book', as: "booking"
  put   'booking_dates/signup/:id',       to: 'booking_dates#signup', as: "signup"
  patch 'booking_dates/signup/:id',       to: 'booking_dates#signup'
  put   'booking_dates/cancel/:id',       to: 'booking_dates#cancel', as: "cancel"
  patch 'booking_dates/cancel/:id',       to: 'booking_dates#cancel'
  put   'admin/booking_dates/signup/:id', to: 'admin/booking_dates#signup'
  patch 'admin/booking_dates/signup/:id', to: 'admin/booking_dates#signup'
  put   'admin/booking_dates/cancel/:id', to: 'admin/booking_dates#cancel'
  patch 'admin/booking_dates/cancel/:id', to: 'admin/booking_dates#cancel'
  put   'admin/tours/highlight/:id',      to: 'admin/tours#highlight', as: "highlight_tour"
  patch 'admin/tours/highlight/:id',      to: 'admin/tours#highlight'
  root to: "tours#index"
end
