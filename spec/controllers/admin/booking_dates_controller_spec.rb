require 'rails_helper'

RSpec.describe Admin::BookingDatesController, type: :controller do

  include Devise::Test::ControllerHelpers


  # attributes
  let!(:tour) {
    FactoryBot.create(:tour)
  }
  let!(:booking_date) {
    FactoryBot.create(:booking_date)
  }
  let!(:company) {
    FactoryBot.create(:company, email: 'test@example.com')
  }
  let!(:booked_date) {
    FactoryBot.create(:booked_date)
  }

  let(:valid_signup_attributes) {
    {id: booking_date.id, company_id: company.id}
  }
  let(:valid_signup_email) {
    {id: booking_date.id, company_email: company.email}
  }

  let(:new_attributes) {
    {day: Date.tomorrow}
  }
  let(:invalid_attributes) {
    {day: "", tour: ""}
  }
  let(:valid_attributes) {
    FactoryBot.attributes_for(:booking_date, tour_id: tour.id)
  }
  let(:invalid_signup_attributes) {
    {id: booking_date.id, company_id: "jane"}
  }
  let(:invalid_company_id) {
    {id: booking_date.id, company_id: 0}
  }
  let(:invalid_company_email) {
    {id: booking_date.id, company_email: "invalid@example.com"}
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
        get :show, params: {id: booking_date.to_param}
        expect(response).to redirect_to( new_manager_session_path )
      end
      it "from GET #new to login page" do
        get :new
        expect(response).to redirect_to( new_manager_session_path )
      end
      it "from GET #show to login page" do
        get :edit, params: {id: booking_date.to_param}
        expect(response).to redirect_to( new_manager_session_path )
      end
      it "from POST #create to login page" do
        post :create, params: {admin_booking_date: invalid_attributes}
        expect(response).to redirect_to( new_manager_session_path )
      end
      it "from PUT #show to login page" do
        put :update, params: {id: booking_date.to_param, admin_booking_date: new_attributes}
        expect(response).to redirect_to( new_manager_session_path )
      end
      it "from PATCH #show to login page" do
        patch :update, params: {id: booking_date.to_param, admin_booking_date: new_attributes}
        expect(response).to redirect_to( new_manager_session_path )
      end
      it "from DELETE #destroy to login page" do
        delete :destroy, params: {id: booking_date.to_param}
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
        get :index, params: {}, session: valid_session
        expect(response).to be_successful
      end
    end

    describe "GET #show" do
      it "returns a success response" do
        get :show, params: {id: booking_date.to_param}, session: valid_session
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
        get :edit, params: {id: booking_date.to_param}, session: valid_session
        expect(response).to be_successful
      end
    end

    describe "POST #create" do
      context "with valid params" do
        it "creates a new Admin::BookingDate" do
          expect {
            post :create, params: {admin_booking_date: valid_attributes}, session: valid_session
          }.to change(BookingDate, :count).by(1)
        end
        it "redirects to the created admin_booking_date" do
          post :create, params: {admin_booking_date: valid_attributes}, session: valid_session
          expect(response).to redirect_to( admin_booking_date_path(BookingDate.last) )
        end
      end
      context "with invalid params" do
        it "returns a success response (i.e. to display the 'new' template)" do
          post :create, params: {admin_booking_date: invalid_attributes}, session: valid_session
          expect(response).to be_successful
        end
      end
    end

    describe "PUT #update" do
      context "with valid params" do
        it "updates the requested admin_booking_date" do
          put :update, params: {id: booking_date.to_param, admin_booking_date: new_attributes}, session: valid_session
          booking_date.reload
          expect( booking_date.day ).to eq( Date.tomorrow )
        end
        it "redirects to the admin_booking_date" do
          put :update, params: {id: booking_date.to_param,
                        admin_booking_date: valid_attributes}, session: valid_session
          expect(response).to redirect_to( admin_booking_date_path(booking_date) )
        end
      end
      context "with invalid params" do
        it "returns a success response (i.e. to display the 'edit' template)" do
          put :update, params: {id: booking_date.to_param,
                        admin_booking_date: invalid_attributes}, session: valid_session
          expect(response).to be_successful
        end
      end
    end

    describe "PUT #signup" do
      context "with valid params" do
        it "updates the requested booking_date with company_id" do
          put :signup, params: {id: booking_date.to_param,
                        admin_booking_date: valid_signup_attributes}, session: valid_session
          booking_date.reload
          expect(booking_date.company_id).to eq(company.id)
        end
        it "updates the requested booking_date with company_email" do
          put :signup, params: {id: booking_date.to_param,
                        admin_booking_date: valid_signup_email}, session: valid_session
          booking_date.reload
          expect(booking_date.company_id).to eq(company.id)
        end
        it "redirects back to the tour" do
          # booking_date = BookingDate.create! valid_attributes
          put :signup, params: {id: booking_date.to_param,
                        admin_booking_date: valid_signup_email}, session: valid_session
          expect(response).to redirect_to(admin_booking_dates_path)
        end
      end

      context "with invalid params" do
        # test with bad: date_id, company_email
        it "returns error on tour page - with invalid_signup_attributes" do
          #booking_date = BookingDate.create! valid_attributes
          put :signup, params: {id: booking_date.to_param,
                        admin_booking_date: invalid_signup_attributes}, session: valid_session
          # expect(response).to be_successful
          expect(response).to redirect_to(admin_booking_dates_path)
        end
        it "returns error on tour page - with bad company_id" do
          #booking_date = BookingDate.create! valid_attributes
          put :signup, params: {id: booking_date.to_param,
                        admin_booking_date: invalid_company_id}, session: valid_session
          # expect(response).to be_successful
          expect(response).to redirect_to(admin_booking_dates_path)
        end
        it "returns error on tour page - with bad company_email" do
          #booking_date = BookingDate.create! valid_attributes
          put :signup, params: {id: booking_date.to_param,
                        admin_booking_date: invalid_company_email}, session: valid_session
          # expect(response).to be_successful
          expect(response).to redirect_to(admin_booking_dates_path)
        end
      end
    end

    describe "DELETE #destroy" do
      it "destroys the requested admin_booking_date" do
        expect {
          delete :destroy, params: {id: booking_date.to_param}, session: valid_session
        }.to change(BookingDate, :count).by(-1)
      end
      it "redirects to the admin_booking_dates list" do
        delete :destroy, params: {id: booking_date.to_param}, session: valid_session
        expect(response).to redirect_to(admin_booking_dates_url)
      end
    end
  end

end
