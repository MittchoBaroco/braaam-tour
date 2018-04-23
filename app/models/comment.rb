class Comment < ApplicationRecord

  belongs_to :tour

  validates :author_name,  presence: true, length: { minimum: 2 }
  validates :comment_body, presence: true, length: { minimum: 6 }
  # validates :comment_body, uniqueness: {
  #                             scope: [:author_name, :tour_id],
  #                             message: "each author and comment must be unique to one tour"}
end
