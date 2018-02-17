class Company < ApplicationRecord
  # has_many :event_dates
  # has_many :events, through: :event_dates

  # validate email & name not empty
  validates :email, presence: true, length: { minimum: 2 },
                                    uniqueness: true
  validates :name,  presence: true, length: { minimum: 2 }

end
