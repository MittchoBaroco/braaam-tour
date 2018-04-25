# frozen_string_literal: true

module TourCommentComponent
  extend ComponentHelper
  property :body, required: true
  property :author_name, required: true
  property :created_at, required: true
end
