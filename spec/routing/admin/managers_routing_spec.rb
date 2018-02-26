require "rails_helper"

RSpec.describe Admin::ManagersController, type: :routing do
  describe "routing" do

    it "routes to #index" do
      expect(:get => "/admin/managers").to route_to("admin/managers#index")
    end

    it "routes to #new" do
      expect(:get => "/admin/managers/new").to route_to("admin/managers#new")
    end

    it "routes to #show" do
      expect(:get => "/admin/managers/1").to route_to("admin/managers#show", :id => "1")
    end

    it "routes to #edit" do
      expect(:get => "/admin/managers/1/edit").to route_to("admin/managers#edit", :id => "1")
    end

    it "routes to #create" do
      expect(:post => "/admin/managers").to route_to("admin/managers#create")
    end

    it "routes to #update via PUT" do
      expect(:put => "/admin/managers/1").to route_to("admin/managers#update", :id => "1")
    end

    it "routes to #update via PATCH" do
      expect(:patch => "/admin/managers/1").to route_to("admin/managers#update", :id => "1")
    end

    it "routes to #destroy" do
      expect(:delete => "/admin/managers/1").to route_to("admin/managers#destroy", :id => "1")
    end

  end
end
