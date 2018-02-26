class Company < ApplicationRecord

  has_many :tour_dates
  has_many :tours, through: :tour_dates

  # validate email & name not empty
  validates :name,  presence: true, length: { minimum: 2 }
  validates :email, presence: true, length: { minimum: 6 },
                    uniqueness: { case_sensitive: true }

end
