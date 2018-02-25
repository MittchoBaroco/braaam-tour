module TourSectionComponent
  extend ComponentHelper
  property :type, required: true

  def title
    case @type
    when "awards"
      t "tour_section_component.award_title"
    end
  end
end
