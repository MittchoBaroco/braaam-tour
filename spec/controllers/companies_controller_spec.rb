require 'rails_helper'

RSpec.describe CompaniesController, type: :controller do

  describe "GET #bookings" do
    it "returns http success" do
      get :bookings
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET #settings" do
    it "returns http success" do
      get :settings
      expect(response).to have_http_status(:success)
    end
  end

end
