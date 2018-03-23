module TourBookingBtnComponent
  extend ComponentHelper
  property :date, required: true

  def status
    # return "mine"
    return "booked" if @date.company_id
    return "open"
  end
end
