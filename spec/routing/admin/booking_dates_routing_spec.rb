require "rails_helper"

RSpec.describe Admin::BookingDatesController, type: :routing do
  describe "routing" do

    it "routes to #index" do
      expect(:get => "/admin/booking_dates").to route_to("admin/booking_dates#index")
    end

    it "routes to #new" do
      expect(:get => "/admin/booking_dates/new").to route_to("admin/booking_dates#new")
    end

    it "routes to #show" do
      expect(:get => "/admin/booking_dates/1").to route_to("admin/booking_dates#show", :id => "1")
    end

    it "routes to #edit" do
      expect(:get => "/admin/booking_dates/1/edit").to route_to("admin/booking_dates#edit", :id => "1")
    end

    it "routes to #create" do
      expect(:post => "/admin/booking_dates").to route_to("admin/booking_dates#create")
    end

    it "routes to #update via PUT" do
      expect(:put => "/admin/booking_dates/1").to route_to("admin/booking_dates#update", :id => "1")
    end

    it "routes to #update via PATCH" do
      expect(:patch => "/admin/booking_dates/1").to route_to("admin/booking_dates#update", :id => "1")
    end

    it "routes to #signup via PUT" do
      expect(:put => "/admin/booking_dates/signup/1").to route_to("admin/booking_dates#signup", :id => "1")
    end

    it "routes to #signup via PATCH" do
      expect(:patch => "/admin/booking_dates/signup/1").to route_to("admin/booking_dates#signup", :id => "1")
    end

    it "routes to #cancel via PUT" do
      expect(:put => "/admin/booking_dates/cancel/1").to route_to("admin/booking_dates#cancel", :id => "1")
    end

    it "routes to #cancel via PATCH" do
      expect(:patch => "/admin/booking_dates/cancel/1").to route_to("admin/booking_dates#cancel", :id => "1")
    end

    it "routes to #destroy" do
      expect(:delete => "/admin/booking_dates/1").to route_to("admin/booking_dates#destroy", :id => "1")
    end

  end
end
