require 'rails_helper'

RSpec.describe CompaniesController, type: :controller do
  before(:each) do
    sign_in company
  end

  let!(:company) {
    FactoryBot.create(:company, email: 'test@example.com')
  }

  let!(:valid_session){{}}

  describe "GET #bookings" do
    it "returns http success" do
      get :bookings, params: {id: company.id }, session: valid_session
      expect(response).to be_successful
    end
  end

  describe "GET #settings" do
    it "returns http success" do
      get :settings, params: {id: company.id }, session: valid_session
      expect(response).to be_successful
    end
  end

  describe "GET #tours" do
    it "returns http success" do
      get :tours, params: {id: company.id }, session: valid_session
      expect(response).to be_successful
    end
  end

end
