module TourBookingBtnComponent
  extend ComponentHelper
  property :date, required: true
  property :status, default: "open"
  property :id, required: true
end
