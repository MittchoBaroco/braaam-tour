class Tour < ApplicationRecord

  CURRENCIES = %w(CHF EUR)

  has_many :awards
  has_many :booking_dates, dependent: :destroy
  has_many :companies,     through: :booking_dates

  has_one_attached :image

  monetize :price_braaam_cents, numericality: { greater_than_or_equal_to: 0 }
  monetize :price_normal_cents, numericality: { greater_than_or_equal_to: 0 }

  validates :title,       presence: true, length: { minimum: 2 }
  validates :description, presence: true, length: { minimum: 2 }
  validates :video_uri,   presence: true, length: { minimum: 2 }
  validates :tech_help,   inclusion: { in: [ true, false ] }
  validates :housing,     inclusion: { in: [ true, false ] }
  validates :catering,    inclusion: { in: [ true, false ] }
  validates :transport,   inclusion: { in: [ true, false ] }

  # default_scope     { after(Date.today) }
  # chaining scopes
  # http://dmitrypol.github.io/2016/10/14/rails-scope-inside-scope.html
  scope :future,  -> { after(Date.today) }
  scope :current, -> { after(Date.today - 1) }
  scope :past,    -> { before(Date.today) }
  # https://ducktypelabs.com/using-scope-with-associations/
  # https://stackoverflow.com/questions/9197649/rails-sort-by-join-table-data
  scope :after,  -> (date) { joins(:booking_dates).
                              where('booking_dates.day > ?', date).
                              order('booking_dates.day ASC') }
  scope :before, -> (date) { joins(:booking_dates).
                              where('booking_dates.day < ?', date).
                              order('booking_dates.day DESC') }

end
