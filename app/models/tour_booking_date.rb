class TourBookingDate < ApplicationRecord

  belongs_to :tour
  belongs_to :company, optional: true

  validates :tour, uniqueness: { scope: :day,
                                message: 'tours may only have one event per-day'
                              }
  validates_date :day,:on => :update
  validates_date :day,:on => :create,
                      :on_or_after => :today,
                      :on_or_after_message => 'must be a date on or after today'

end
