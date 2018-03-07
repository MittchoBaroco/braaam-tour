require 'rails_helper'

RSpec.describe "Admin::BookingDates", type: :request do

  include Devise::Test::IntegrationHelpers

  context "manager UNAUTHENTICATED" do
    describe "GET /admin_booking_dates" do
      it "admin_booking_dates#index" do
        get admin_booking_dates_path
        expect(response).to have_http_status(302)
      end
    end
  end

  context "manager AUTHENTICATED" do
    before(:each) do
      manager = FactoryBot.create(:manager, email: "user@example.org",
                                          password: "very-secret",
                                          password_confirmation: "very-secret")
      login_as manager
    end
    describe "GET /admin_booking_dates" do
      it "admin_booking_dates#index" do
        get admin_booking_dates_path
        expect(response).to have_http_status(200)
      end
    end
  end
end
