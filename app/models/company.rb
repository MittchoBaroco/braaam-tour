class Company < ApplicationRecord

  has_many :booking_dates
  has_many :tours, through: :booking_dates

  # validate email & name not empty
  validates :name,  presence: true, length: { minimum: 2 }
  validates :email, presence: true, length: { minimum: 6 },
                    uniqueness: { case_sensitive: true }

end
