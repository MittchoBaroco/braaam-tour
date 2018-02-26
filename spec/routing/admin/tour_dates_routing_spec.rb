require "rails_helper"

RSpec.describe Admin::TourDatesController, type: :routing do
  describe "routing" do

    it "routes to #index" do
      expect(:get => "/admin/tour_dates").to route_to("admin/tour_dates#index")
    end

    it "routes to #new" do
      expect(:get => "/admin/tour_dates/new").to route_to("admin/tour_dates#new")
    end

    it "routes to #show" do
      expect(:get => "/admin/tour_dates/1").to route_to("admin/tour_dates#show", :id => "1")
    end

    it "routes to #edit" do
      expect(:get => "/admin/tour_dates/1/edit").to route_to("admin/tour_dates#edit", :id => "1")
    end

    it "routes to #create" do
      expect(:post => "/admin/tour_dates").to route_to("admin/tour_dates#create")
    end

    it "routes to #update via PUT" do
      expect(:put => "/admin/tour_dates/1").to route_to("admin/tour_dates#update", :id => "1")
    end

    it "routes to #update via PATCH" do
      expect(:patch => "/admin/tour_dates/1").to route_to("admin/tour_dates#update", :id => "1")
    end

    it "routes to #destroy" do
      expect(:delete => "/admin/tour_dates/1").to route_to("admin/tour_dates#destroy", :id => "1")
    end

  end
end
