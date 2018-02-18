class Award < ApplicationRecord

  belongs_to :tour

  validates :caption,     presence: true, length: { minimum: 2 }
  validates :institution, presence: true, length: { minimum: 2 }
  validates :award_year,  numericality: { only_integer: true,
                                          greater_than_or_equal_to: 1950 }
  validates :caption, uniqueness: { scope: [:institution, :award_year],
                                    message: "award must be unique in fields: caption, award_year and institution"
                                  }
end
