class Company < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable#, :validatable

  has_many :booking_dates
  has_many :tours, through: :booking_dates

  # validate email & name not empty
  validates :name,  presence: true, length: { minimum: 2 }
  validates :email, presence: true, length: { minimum: 6 },
                    uniqueness: { case_sensitive: true }

  validates :company_address_line1, presence: true, length: { minimum: 6 }
  validates :company_address_line2, length: { minimum: 1 }, allow_nil: true
  validates :company_country, presence: true, length: { minimum: 2 }
  validates :company_npa, presence: true, length: { minimum: 1 }
  validates :company_city, presence: true, length: { minimum: 2 }
  validates :reference_person_full_name, presence: true, length: { minimum: 2 }

end
