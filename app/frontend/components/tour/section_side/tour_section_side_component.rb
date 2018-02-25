module TourSectionSideComponent
  extend ComponentHelper
  property :type, required: true

  def title
    case @type
    when "needs"
      t ".needs_title"
    when "dates"
      t ".dates_title"
    when "prices"
      t ".prices_title"
    end
  end
end
