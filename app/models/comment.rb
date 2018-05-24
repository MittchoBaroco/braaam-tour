class Comment < ApplicationRecord

  belongs_to :tour
  belongs_to :company, optional: true

  validates :author_name, length: { minimum: 2 }, allow_blank: true
  validates :comment_body, presence: true, length: { minimum: 3 }
  # validates :comment_body, uniqueness: {
  #                             scope: [:author_name, :tour_id],
  #                             message: "each author and comment must be unique to one tour"}

  def author_name
    return self[:author_name] if company.blank?
    return company.name
  end
end
