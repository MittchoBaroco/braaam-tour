class Tour < ApplicationRecord

  CURRENCIES = %w(CHF EUR)

  # TODO: add new start & end date fields - sort on them (queried from bookings)
  # TODO: distinct for uniq returns - find an better solution - add back sorting

  after_touch do
    dates = self.booking_dates.to_a
    has_dates = dates.empty?

    new_start_date = if has_dates then nil else dates.first.day end
    self.update tour_start_date: new_start_date unless tour_start_date == new_start_date

    new_end_date = if has_dates then nil else dates.last.day end
    self.update tour_end_date: new_end_date unless tour_end_date == new_end_date
  end

  belongs_to :creator, foreign_key: "company_id", class_name: "Company", optional: true

  has_many :awards,   inverse_of: :tour, dependent: :destroy
  has_many :comments, inverse_of: :tour, dependent: :destroy
  has_many :booking_dates, -> { order(day: :asc) }, inverse_of: :tour, dependent: :destroy
  has_many :companies,     through: :booking_dates

  # https://evilmartians.com/chronicles/rails-5-2-active-storage-and-beyond
  has_one_attached :cover_image
  has_one_attached :tech_sheet
  # has_many_attached :carosel_images

  # Use EUR as the model level currency
  register_currency :eur

  monetize :price_braaam_cents, numericality: { greater_than_or_equal_to: 0 }
  monetize :price_normal_cents, numericality: { greater_than_or_equal_to: 0 }

  accepts_nested_attributes_for :awards,
                          reject_if: :all_blank, allow_destroy: true
  accepts_nested_attributes_for :booking_dates,
                          reject_if: :all_blank, allow_destroy: true
  accepts_nested_attributes_for :comments,
                          reject_if: :all_blank, allow_destroy: true

  validates :tour_caption,  presence: true, length: { minimum: 2 }
  validates :artist_country,presence: true, length: { minimum: 2 }
  validates :title,       presence: true, length: { minimum: 2 }
  validates :description, presence: true, length: { minimum: 2 }
  # validate url
  validates :video_uri,   allow_blank: true,
                          format: { with: /\Ahttps?:\/\/[\S.-]+\.[\S.-]+\z/i,
                                    message: "please enter a valid url" }
  validates :housing,     inclusion: { in: [ true, false ] }
  validates :catering,    inclusion: { in: [ true, false ] }

  # validation for sorting field
  # validates_date :tour_start_date,:on => :update
  # validates_date :tour_start_date,:on => :create,
  #                     :on_or_after => :today,
  #                     :on_or_after_message => 'must be a date on or after today'
  #
  # validates_date :tour_end_date,:on => :update
  # validates_date :tour_end_date,:on => :create,
  #                     :on_or_after => :today,
  #                     :on_or_after_message => 'must be a date on or after today'

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
  scope :after,  -> (date) { distinct.joins(:booking_dates).
                    where('booking_dates.day > ?', date).
                    includes(:booking_dates).
                    order('booking_dates.day ASC') }
  # scope :after,  -> (date) { distinct.includes(:booking_dates).
  #                   where('booking_dates.day > ?', date).
  #                   references(:booking_dates) }
  #                   # .order('booking_dates.day ASC') }
  scope :before, -> (date) { distinct.joins(:booking_dates).
                    where('booking_dates.day < ?', date).
                    includes(:booking_dates).
                    references(:booking_dates).
                    order('booking_dates.day DESC') }
  # scope :before, -> (date) { distinct.includes(:booking_dates).
  #                   where('booking_dates.day < ?', date).
  #                   references(:booking_dates) }
  #                   # .order('booking_dates.day DESC') }

  def booked_days_count
    self.booking_dates.where.not(company_id: nil).count
  end

  def need_tech_help?
    self.tech_sheet.attached?
  end

  def title_with_country
    "#{title} (#{artist_country})"
  end

  def creator_name
     return "Braaam" if creator.blank?
     return creator.name
  end

  def braaam_tour?
    creator.blank?
  end
end
