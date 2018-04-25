module TourSectionComponent
  extend ComponentHelper
  property :type, required: true

  def title
    case @type
    when "awards"
      t "tour_section_component.award_title"
    when "comments"
      t "tour_section_component.comment_title"
    end
  end
end
