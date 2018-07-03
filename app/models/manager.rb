class Manager < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :recoverable,
         :rememberable, :trackable, :validatable

 validates :full_name,  presence: true, length: { minimum: 2 },
                        uniqueness: { case_sensitive: false }
 validates :email,      presence: true, length: { minimum: 6 },
                        uniqueness: { case_sensitive: false }

end
