require 'rails_helper'

RSpec.describe Admin::AwardsController, type: :controller do

  let(:valid_session) { {} }
  include Devise::Test::ControllerHelpers

  # test attributes
  let!(:tour) {
    FactoryBot.create(:tour)
  }
  let!(:award) {
    FactoryBot.create(:award)
  }
  let(:new_attributes) {
    {caption: "GREAT"}
  }
  let(:valid_attributes) {
    FactoryBot.attributes_for(:award, tour_id: tour.id)
  }
  let(:invalid_attributes) {
    { caption: "", institution: "", country: "", award_year: "", tour_id: "" }
  }

  # user & session - for security / authorization testing
  let!(:manager) { FactoryBot.create(:manager) }
  let!(:valid_session) { {manager_id: manager.id} }
  # let!(:valid_session) { {} }

  context "UNAUTHENTICATED" do
    describe "redirect" do
      it "from GET #index to login page" do
        get :index
        expect(response).to redirect_to( new_manager_session_path )
      end
      it "from GET #show to login page" do
        get :show, params: {id: tour.to_param}
        expect(response).to redirect_to( new_manager_session_path )
      end
      it "from GET #new to login page" do
        get :new
        expect(response).to redirect_to( new_manager_session_path )
      end
      it "from GET #show to login page" do
        get :edit, params: {id: award.to_param}
        expect(response).to redirect_to( new_manager_session_path )
      end
      it "from POST #create to login page" do
        post :create, params: {admin_award: invalid_attributes}
        expect(response).to redirect_to( new_manager_session_path )
      end
      it "from PUT #show to login page" do
        put :update, params: {id: award.to_param, admin_award: new_attributes}
        expect(response).to redirect_to( new_manager_session_path )
      end
      it "from PATCH #show to login page" do
        patch :update, params: {id: award.to_param, admin_award: new_attributes}
        expect(response).to redirect_to( new_manager_session_path )
      end
      it "from DELETE #destroy to login page" do
        delete :destroy, params: {id: award.to_param}
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
        # award = Award.create! valid_attributes
        get :index, params: {}, session: valid_session
        expect(response).to be_successful
      end
    end

    describe "GET #show" do
      it "returns a success response" do
        # award = Award.create! valid_attributes
        get :show, params: {id: award.to_param}, session: valid_session
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
        # award = Award.create! valid_attributes
        get :edit, params: {id: award.to_param}, session: valid_session
        expect(response).to be_successful
      end
    end

    describe "POST #create" do
      context "with valid params" do
        it "creates a new Award via Admin" do
          expect {
            post :create, params: {admin_award: valid_attributes}, session: valid_session
          }.to change(Award, :count).by(1)
        end

        it "redirects to the created admin_award" do
          post :create, params: {admin_award: valid_attributes}, session: valid_session
          expect(response).to redirect_to( admin_award_path(Award.last) )
        end
      end

      context "with invalid params" do
        it "returns a success response (i.e. to display the 'new' template)" do
          post :create, params: {admin_award: invalid_attributes}, session: valid_session
          expect(response).to be_successful
        end
      end
    end

    describe "PUT #update" do
      context "with valid params" do
        it "updates the requested admin_award" do
          put :update, params: {id: award.to_param, admin_award: new_attributes}, session: valid_session
          award.reload
          expect(award.caption).to eq("GREAT")
        end
        it "redirects to the admin_award" do
          put :update, params: {id: award.to_param, admin_award: valid_attributes}, session: valid_session
          expect(response).to redirect_to( admin_award_path(award) )
        end
      end
      context "with invalid params" do
        it "returns a success response (i.e. to display the 'edit' template)" do
          put :update, params: {id: award.to_param, admin_award: invalid_attributes}, session: valid_session
          expect(response).to be_successful
        end
      end
    end

    describe "DELETE #destroy" do
      it "destroys the requested admin_award" do
        expect {
          delete :destroy, params: {id: award.to_param}, session: valid_session
        }.to change(Award, :count).by(-1)
      end
      it "redirects to the admin_awards list" do
        delete :destroy, params: {id: award.to_param}, session: valid_session
        expect(response).to redirect_to(admin_awards_url)
      end
    end
  end

end
