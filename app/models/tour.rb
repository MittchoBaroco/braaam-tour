class Tour < ApplicationRecord

  CURRENCIES = %w(CHF EUR)

  # TODO: add new start & end date fields - sort on them (queried from bookings)
  # TODO: distinct for uniq returns - find an better solution - add back sorting

  has_many :awards, inverse_of: :tour
  has_many :booking_dates, -> { order(day: :asc) }, inverse_of: :tour, dependent: :destroy
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

  default_scope      { with_attached_cover_image }
  scope :future,  -> { after(Date.today) }
  scope :past,    -> { before(Date.today) }
  scope :current, -> { after(Date.today - 1) }
  scope :index_collection, -> { current.with_image }
  scope :show_collection, -> (id){ current.with_image.where.not(id: id) }
  # :with_image scope MUST be used in combination with other scopes!
  scope :with_image, -> { distinct.includes(:booking_dates).
                    where('active_storage_attachments.record_type = ?', 'Tour').
                    where('active_storage_attachments.name = ?', 'cover_image')
                  }
  # TODO: solve order and limit conflict when using includes
  # order_by and limit conflict - limit is more needed than order
  scope :after,  -> (date) { distinct.includes(:booking_dates).
                    where('booking_dates.day > ?', date).
                    references(:booking_dates) }
                    # .order('booking_dates.day ASC') }
  scope :before, -> (date) { distinct.includes(:booking_dates).
                    where('booking_dates.day < ?', date).
                    references(:booking_dates) }
                    # .order('booking_dates.day DESC') }

  def booked_days_count
    self.booking_dates.where.not(company_id: nil).count
  end
end
