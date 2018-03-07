require "rails_helper"

RSpec.describe BookingDatesController, type: :routing do
  describe "routing" do

    it "routes to #signup via PUT" do
      expect(:put => "/booking_dates/signup/1").to route_to(
                        "booking_dates#signup", :id => "1")
    end

    it "routes to #signup via PATCH" do
      expect(:patch => "/booking_dates/signup/1").to route_to(
                        "booking_dates#signup", :id => "1")
    end

  end
end
