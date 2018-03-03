require 'rails_helper'

RSpec.describe "Admin::TourDates", type: :request do
  xdescribe "GET /admin_tour_dates" do
    it "admin_tour_dates#index" do
      get admin_tour_dates_path
      expect(response).to have_http_status(200)
    end
  end
end
