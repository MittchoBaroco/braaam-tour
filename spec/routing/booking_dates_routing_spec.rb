require "rails_helper"

RSpec.describe BookingDatesController, type: :routing do
  describe "routing" do

    it "routes to #commit via PUT" do
      expect(:put => "/booking_dates/commit/1").to route_to(
                        "booking_dates#commit", :id => "1")
    end

    it "routes to #commit via PATCH" do
      expect(:patch => "/booking_dates/commit/1").to route_to(
                        "booking_dates#commit", :id => "1")
    end

  end
end
