class BookingDate < ApplicationRecord

  belongs_to :tour, touch: true
  belongs_to :company, optional: true

  validates :tour, uniqueness: { scope: :day,
                                message: 'tours may only have one event per-day'
                              }
  validates :close, inclusion: { in: [ true, false ] }
  validates_date :day,:on => :update
  validates_date :day,:on => :create,
                      :on_or_after => :today,
                      :on_or_after_message => 'must be a date on or after today'

  # https://ducktypelabs.com/using-scope-with-associations/
  # default_scope     { where('day >= ?', Date.today) }
  scope :future, -> { after(Date.today) }
  scope :current, ->{ after(Date.today - 1) }
  scope :past,   -> { before(Date.today) }
  scope :after,  -> (date) { where('day > ?', date).
                            order(day: :asc, tour_id: :asc) }
  scope :before, -> (date) { where('day < ?', date).
                            order(day: :desc, tour_id: :desc) }

  scope :closed, -> { where.not(company_id: nil) }

  def is_close?
    self.close or self.company_id
  end
end
