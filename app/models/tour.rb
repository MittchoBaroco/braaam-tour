class Tour < ApplicationRecord

  CURRENCIES = %w(CHF EUR)

  has_many :awards, inverse_of: :tour
  has_many :booking_dates, inverse_of: :tour, dependent: :destroy
  has_many :companies,     through: :booking_dates

  # https://evilmartians.com/chronicles/rails-5-2-active-storage-and-beyond
  has_one_attached :cover_image
  # has_many_attached :carosel_images

  monetize :price_braaam_cents, numericality: { greater_than_or_equal_to: 0 }
  monetize :price_normal_cents, numericality: { greater_than_or_equal_to: 0 }

  accepts_nested_attributes_for :awards,
                          reject_if: :all_blank, allow_destroy: true
  accepts_nested_attributes_for :booking_dates,
                          reject_if: :all_blank, allow_destroy: true

  validates :title,       presence: true, length: { minimum: 2 }
  validates :description, presence: true, length: { minimum: 2 }
  # validate url
  validates :video_uri,   allow_blank: true,
                          format: { with: /\Ahttps?:\/\/[\S.-]+\.[\S.-]+\z/i,
                                    message: "please enter a valid url" }
  validates :tech_help,   inclusion: { in: [ true, false ] }
  validates :housing,     inclusion: { in: [ true, false ] }
  validates :catering,    inclusion: { in: [ true, false ] }
  validates :transport,   inclusion: { in: [ true, false ] }

  # default_scope     { after(Date.today) }
  scope :future,  -> { after(Date.today) }
  scope :past,    -> { before(Date.today) }
  scope :current, -> { after(Date.today - 1) }
  scope :with_image, -> { includes(:booking_dates).
                      where('active_storage_attachments.record_type = ?', 'Tour').
                      where('active_storage_attachments.name = ?', 'cover_image') }
  scope :after,  -> (date) { distinct.includes(:booking_dates).
                      where('booking_dates.day > ?', date).
                      references(:booking_dates).
                      order('booking_dates.day ASC').
                      with_attached_cover_image }
  scope :before, -> (date) { distinct.includes(:booking_dates).
                      where('booking_dates.day < ?', date).
                      references(:booking_dates).
                      order('booking_dates.day DESC').
                      with_attached_cover_image }

end
