require 'rails_helper'

RSpec.describe Admin::TourDatesController, type: :controller do

  # This should return the minimal set of attributes required to create a valid
  # Admin::TourDate. As you add validations to Admin::TourDate, be sure to
  # adjust the attributes here as well.
  let!(:tour) {
    FactoryBot.create(:tour)
  }
  let(:valid_attributes) {
    FactoryBot.attributes_for(:tour_date, tour_id: tour.id)
  }

  let(:invalid_attributes) {
    {day: "", tour: ""}
  }

  # This should return the minimal set of values that should be in the session
  # in order to pass any filters (e.g. authentication) defined in
  # Admin::TourDatesController. Be sure to keep this updated too.
  let(:valid_session) { {} }

  describe "GET #index" do
    it "returns a success response" do
      tour_date = TourDate.create! valid_attributes
      get :index, params: {}, session: valid_session
      expect(response).to be_successful
    end
  end

  describe "GET #show" do
    it "returns a success response" do
      tour_date = TourDate.create! valid_attributes
      get :show, params: {id: tour_date.to_param}, session: valid_session
      expect(response).to be_successful
    end
  end

  describe "GET #new" do
    it "returns a success response" do
      get :new, params: {}, session: valid_session
      expect(response).to be_successful
    end
  end

  describe "GET #edit" do
    it "returns a success response" do
      tour_date = TourDate.create! valid_attributes
      get :edit, params: {id: tour_date.to_param}, session: valid_session
      expect(response).to be_successful
    end
  end

  describe "POST #create" do
    context "with valid params" do
      it "creates a new Admin::TourDate" do
        expect {
          post :create, params: {admin_tour_date: valid_attributes}, session: valid_session
        }.to change(TourDate, :count).by(1)
      end

      it "redirects to the created admin_tour_date" do
        post :create, params: {admin_tour_date: valid_attributes}, session: valid_session
        expect(response).to redirect_to( admin_tour_date_path(TourDate.last) )
      end
    end

    context "with invalid params" do
      it "returns a success response (i.e. to display the 'new' template)" do
        post :create, params: {admin_tour_date: invalid_attributes}, session: valid_session
        expect(response).to be_successful
      end
    end
  end

  describe "PUT #update" do
    context "with valid params" do
      tomorrow = Date.today + 1
      let(:new_attributes) {
        { day: tomorrow }
      }

      it "updates the requested admin_tour_date" do
        tour_date = TourDate.create! valid_attributes
        put :update, params: {id: tour_date.to_param, admin_tour_date: new_attributes}, session: valid_session
        tour_date.reload
        expect( tour_date.day ).to eq( tomorrow )
      end

      it "redirects to the admin_tour_date" do
        tour_date = TourDate.create! valid_attributes
        put :update, params: {id: tour_date.to_param, admin_tour_date: valid_attributes}, session: valid_session
        expect(response).to redirect_to( admin_tour_date_path(tour_date) )
      end
    end

    context "with invalid params" do
      it "returns a success response (i.e. to display the 'edit' template)" do
        tour_date = TourDate.create! valid_attributes
        put :update, params: {id: tour_date.to_param, admin_tour_date: invalid_attributes}, session: valid_session
        expect(response).to be_successful
      end
    end
  end

  describe "DELETE #destroy" do
    it "destroys the requested admin_tour_date" do
      tour_date = TourDate.create! valid_attributes
      expect {
        delete :destroy, params: {id: tour_date.to_param}, session: valid_session
      }.to change(TourDate, :count).by(-1)
    end

    it "redirects to the admin_tour_dates list" do
      tour_date = TourDate.create! valid_attributes
      delete :destroy, params: {id: tour_date.to_param}, session: valid_session
      expect(response).to redirect_to(admin_tour_dates_url)
    end
  end

end
