require 'rails_helper'

RSpec.describe "Admin::TourBookingDates", type: :request do
  xdescribe "GET /admin_tour_booking_dates" do
    it "admin_tour_booking_dates#index" do
      get admin_tour_booking_dates_path
      expect(response).to have_http_status(200)
    end
  end
end
