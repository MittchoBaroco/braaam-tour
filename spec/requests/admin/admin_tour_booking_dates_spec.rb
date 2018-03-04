require 'rails_helper'

RSpec.describe "Admin::BookingDates", type: :request do
  xdescribe "GET /admin_booking_dates" do
    it "admin_booking_dates#index" do
      get admin_booking_dates_path
      expect(response).to have_http_status(200)
    end
  end
end
