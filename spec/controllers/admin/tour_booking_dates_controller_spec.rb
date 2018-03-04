require 'rails_helper'

RSpec.describe Admin::TourBookingDatesController, type: :controller do

  include Devise::Test::ControllerHelpers

  # attributes
  let!(:tour) {
    FactoryBot.create(:tour)
  }
  let!(:tour_booking_date) {
    FactoryBot.create(:tour_booking_date)
  }
  let(:new_attributes) {
    {day: Date.tomorrow}
  }
  let(:invalid_attributes) {
    {day: "", tour: ""}
  }
  let(:valid_attributes) {
    FactoryBot.attributes_for(:tour_booking_date, tour_id: tour.id)
  }

  # user & session - for security / authorization testing
  let!(:manager) { FactoryBot.create(:manager) }
  # let!(:valid_session) { {} }
  let!(:valid_session) { {manager_id: manager.id} }


  context "UNAUTHENTICATED" do
    describe "redirect" do
      it "from GET #index to login page" do
        get :index
        expect(response).to redirect_to( new_manager_session_path )
      end
      it "from GET #show to login page" do
        get :show, params: {id: tour_booking_date.to_param}
        expect(response).to redirect_to( new_manager_session_path )
      end
      it "from GET #new to login page" do
        get :new
        expect(response).to redirect_to( new_manager_session_path )
      end
      it "from GET #show to login page" do
        get :edit, params: {id: tour_booking_date.to_param}
        expect(response).to redirect_to( new_manager_session_path )
      end
      it "from POST #create to login page" do
        post :create, params: {admin_tour_booking_date: invalid_attributes}
        expect(response).to redirect_to( new_manager_session_path )
      end
      it "from PUT #show to login page" do
        put :update, params: {id: tour_booking_date.to_param, admin_tour_booking_date: new_attributes}
        expect(response).to redirect_to( new_manager_session_path )
      end
      it "from PATCH #show to login page" do
        patch :update, params: {id: tour_booking_date.to_param, admin_tour_booking_date: new_attributes}
        expect(response).to redirect_to( new_manager_session_path )
      end
      it "from DELETE #destroy to login page" do
        delete :destroy, params: {id: tour_booking_date.to_param}
        expect(response).to redirect_to( new_manager_session_path )
      end
    end
  end

  context "AUTHENTICATED as manager" do

    # Devise Valid Session testing - requires more:
    # https://github.com/plataformatec/devise/wiki/how-to:-stub-authentication-in-controller-specs
    before(:each) do
      sign_in manager
    end

    describe "GET #index" do
      it "returns a success response" do
        # tour_booking_date = TourBookingDate.create! valid_attributes
        get :index, params: {}, session: valid_session
        expect(response).to be_successful
      end
    end

    describe "GET #show" do
      it "returns a success response" do
        # tour_booking_date = TourBookingDate.create! valid_attributes
        get :show, params: {id: tour_booking_date.to_param}, session: valid_session
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
        # tour_booking_date = TourBookingDate.create! valid_attributes
        get :edit, params: {id: tour_booking_date.to_param}, session: valid_session
        expect(response).to be_successful
      end
    end

    describe "POST #create" do
      context "with valid params" do
        it "creates a new Admin::TourBookingDate" do
          expect {
            post :create, params: {admin_tour_booking_date: valid_attributes}, session: valid_session
          }.to change(TourBookingDate, :count).by(1)
        end
        it "redirects to the created admin_tour_booking_date" do
          post :create, params: {admin_tour_booking_date: valid_attributes}, session: valid_session
          expect(response).to redirect_to( admin_tour_booking_date_path(TourBookingDate.last) )
        end
      end
      context "with invalid params" do
        it "returns a success response (i.e. to display the 'new' template)" do
          post :create, params: {admin_tour_booking_date: invalid_attributes}, session: valid_session
          expect(response).to be_successful
        end
      end
    end

    describe "PUT #update" do
      context "with valid params" do
        it "updates the requested admin_tour_booking_date" do
          # tour_booking_date = TourBookingDate.create! valid_attributes
          put :update, params: {id: tour_booking_date.to_param, admin_tour_booking_date: new_attributes}, session: valid_session
          tour_booking_date.reload
          expect( tour_booking_date.day ).to eq( Date.tomorrow )
        end
        it "redirects to the admin_tour_booking_date" do
          # tour_booking_date = TourBookingDate.create! valid_attributes
          put :update, params: {id: tour_booking_date.to_param, admin_tour_booking_date: valid_attributes}, session: valid_session
          expect(response).to redirect_to( admin_tour_booking_date_path(tour_booking_date) )
        end
      end
      context "with invalid params" do
        it "returns a success response (i.e. to display the 'edit' template)" do
          # tour_booking_date = TourBookingDate.create! valid_attributes
          put :update, params: {id: tour_booking_date.to_param, admin_tour_booking_date: invalid_attributes}, session: valid_session
          expect(response).to be_successful
        end
      end
    end

    describe "DELETE #destroy" do
      it "destroys the requested admin_tour_booking_date" do
        # tour_booking_date = TourBookingDate.create! valid_attributes
        expect {
          delete :destroy, params: {id: tour_booking_date.to_param}, session: valid_session
        }.to change(TourBookingDate, :count).by(-1)
      end
      it "redirects to the admin_tour_booking_dates list" do
        # tour_booking_date = TourBookingDate.create! valid_attributes
        delete :destroy, params: {id: tour_booking_date.to_param}, session: valid_session
        expect(response).to redirect_to(admin_tour_booking_dates_url)
      end
    end
  end

end
