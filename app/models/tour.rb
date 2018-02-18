class Tour < ApplicationRecord

  CURRENCIES = %w(CHF EUR)

  has_many :awards
  has_many :tour_dates
  has_many :companies, through: :tour_dates

  has_one_attached :image

  monetize :price_braaam_cents, allow_nil: false,
                                numericality: { greater_than_or_equal_to: 0 }
  monetize :price_normal_cents, allow_nil: false,
                                numericality: { greater_than_or_equal_to: 0 }

  # validates :image,      presence: true

  validates :title,      presence: true, length: { minimum: 2 }
  validates :description,presence: true, length: { minimum: 2 }
  validates :video_uri,  presence: true, length: { minimum: 2 }
  validates :tech_help,  inclusion: { in: [ true, false ] }
  validates :housing,    inclusion: { in: [ true, false ] }
  validates :catering,   inclusion: { in: [ true, false ] }
  validates :transport,  inclusion: { in: [ true, false ] }

end
