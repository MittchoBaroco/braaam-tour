require 'rails_helper'

RSpec.describe ToursController, type: :controller do
  let!(:tour1)      { FactoryBot.create(:tour, title: "Tour1") }
  let!(:tour2)      { FactoryBot.create(:tour_w_image, title: "Tour2") }
  let!(:date_today) { FactoryBot.create(:booking_date,
                                        day: (Date.today), tour_id: tour2.id) }

  let(:valid_session) { {} }

  describe "GET #index" do
    it "returns a success response" do
      get :index, params: {}, session: valid_session
      expect(response).to be_successful
    end
  end

  describe "GET #show" do
    it "returns a success response" do
      get :show, params: {id: tour1.to_param}, session: valid_session
      expect(response).to be_successful
    end
  end
end
