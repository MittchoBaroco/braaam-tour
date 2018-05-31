require "rails_helper"

RSpec.describe ToursController, type: :routing do
  describe "routing" do

    it "routes to #index" do
      expect(:get => "/tours").to route_to("tours#index")
    end

    it "routes to #show" do
      expect(:get => "/tours/1").to route_to("tours#show", :id => "1")
    end

    it "routes to #new" do
      expect(:get => "/tours/new").to route_to("tours#new")
    end

    it "routes to #edit" do
      expect(:get => "/tours/edit").to route_to("tours#edit")
    end

  end
end
