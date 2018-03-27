module TourBookingBtnComponent
  extend ComponentHelper
  property :date, required: true

  def status
    # return "mine"
    return "booked" if @date.company_id
    return "open"
  end

  def link
    return '' if close?
    return booking_path(@date.id)
  end

  def close?
    status.eql?("booked")
  end
end
