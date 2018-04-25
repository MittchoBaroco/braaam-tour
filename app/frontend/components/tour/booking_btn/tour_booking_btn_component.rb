module TourBookingBtnComponent
  extend ComponentHelper
  property :date, required: true

  def status
    # return "mine"
    return "booked" if @date.is_close?
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
