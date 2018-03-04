require 'rails_helper'

RSpec.describe "BookingDates", type: :request do
  describe "GET /booking_dates" do
    it "redirects away from non-existent index" do
      # get booking_dates_path
      get "/booking_dates/"
      expect(response).to have_http_status(301)
    end
  end
  describe "PUT /booking_dates" do
    it "redirects away from non-existent index" do
      # put booking_dates_path
      put "/booking_dates/"
      expect(response).to have_http_status(301)
    end
  end
end
