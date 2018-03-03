require 'rails_helper'


RSpec.describe Admin::ManagersController, type: :controller do

  include Devise::Test::ControllerHelpers

  # test attributes
  let(:new_attributes) {
    {full_name: "Bill"}
  }
  let(:valid_attributes) {
    FactoryBot.attributes_for(:manager, full_name: "Elliott")
  }
  let(:invalid_attributes) {
      {full_name: "", email: "", password: ""}
  }
  # user & session - for security / authorization testing
  let!(:manager) { FactoryBot.create(:manager, full_name: "BRAAAM") }
  let!(:valid_session) { {manager_id: manager.id} }
  # let!(:valid_session) { {} }

  context "UNAUTHENTICATED" do
    describe "redirect" do
      it "from GET #index to login page" do
        get :index
        expect(response).to redirect_to( new_manager_session_path )
      end
      it "from GET #show to login page" do
        get :show, params: {id: manager.to_param}
        expect(response).to redirect_to( new_manager_session_path )
      end
      it "from GET #new to login page" do
        get :new
        expect(response).to redirect_to( new_manager_session_path )
      end
      it "from GET #show to login page" do
        get :edit, params: {id: manager.to_param}
        expect(response).to redirect_to( new_manager_session_path )
      end
      it "from POST #create to login page" do
        post :create, params: {admin_tour: invalid_attributes}
        expect(response).to redirect_to( new_manager_session_path )
      end
      it "from PUT #show to login page" do
        put :update, params: {id: manager.to_param, admin_tour: new_attributes}
        expect(response).to redirect_to( new_manager_session_path )
      end
      it "from PATCH #show to login page" do
        patch :update, params: {id: manager.to_param, admin_tour: new_attributes}
        expect(response).to redirect_to( new_manager_session_path )
      end
      it "from DELETE #destroy to login page" do
        delete :destroy, params: {id: manager.to_param}
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
        get :show, params: {id: manager.to_param}, session: valid_session
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
        get :edit, params: {id: manager.to_param}, session: valid_session
        expect(response).to be_successful
      end
    end

    describe "POST #create" do
      context "with valid params" do
        it "creates a new Admin::Manager" do
          expect {
            post :create, params: {admin_manager: valid_attributes}, session: valid_session
          }.to change(Manager, :count).by(1)
        end
        it "redirects to the created admin_manager" do
          post :create, params: {admin_manager: valid_attributes}, session: valid_session
          expect(response).to redirect_to( admin_manager_path(Manager.last) )
        end
      end
      context "with invalid params" do
        it "returns a success response (i.e. to display the 'new' template)" do
          post :create, params: {admin_manager: invalid_attributes}, session: valid_session
          expect(response).to be_successful
        end
      end
    end

    describe "PUT #update" do
      context "with valid params" do
        it "updates the requested admin_manager" do
          put :update, params: {id: manager.to_param, admin_manager: new_attributes}, session: valid_session
          manager.reload
          expect(manager.full_name).to eq("Bill")
        end
        it "redirects to the admin_manager" do
          put :update, params: {id: manager.to_param, admin_manager: valid_attributes}, session: valid_session
          expect(response).to redirect_to( admin_manager_path(manager) )
        end
      end
      context "with invalid params" do
        it "returns a success response (i.e. to display the 'edit' template)" do
          put :update, params: {id: manager.to_param, admin_manager: invalid_attributes}, session: valid_session
          expect(response).to be_successful
        end
      end
    end

    describe "DELETE #destroy" do
      it "destroys the requested admin_manager" do
        expect {
          delete :destroy, params: {id: manager.to_param}, session: valid_session
        }.to change(Manager, :count).by(-1)
      end
      it "redirects to the admin_managers list" do
        delete :destroy, params: {id: manager.to_param}, session: valid_session
        expect(response).to redirect_to(admin_managers_url)
      end
    end
  end

end
