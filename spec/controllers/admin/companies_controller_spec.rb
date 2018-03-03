require 'rails_helper'

RSpec.describe Admin::CompaniesController, type: :controller do

  include Devise::Test::ControllerHelpers

  # test attributes
  let!(:company) {
    FactoryBot.create(:company)
  }
  let(:new_attributes) {
    {name: "BigCo"}
  }
  let(:valid_attributes) {
    FactoryBot.attributes_for(:company)
  }
  let(:invalid_attributes) {
    {name: "", email: ""}
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
        get :show, params: {id: company.to_param}
        expect(response).to redirect_to( new_manager_session_path )
      end
      it "from GET #new to login page" do
        get :new
        expect(response).to redirect_to( new_manager_session_path )
      end
      it "from GET #show to login page" do
        get :edit, params: {id: company.to_param}
        expect(response).to redirect_to( new_manager_session_path )
      end
      it "from POST #create to login page" do
        post :create, params: {admin_company: invalid_attributes}
        expect(response).to redirect_to( new_manager_session_path )
      end
      it "from PUT #show to login page" do
        put :update, params: {id: company.to_param, admin_company: new_attributes}
        expect(response).to redirect_to( new_manager_session_path )
      end
      it "from PATCH #show to login page" do
        patch :update, params: {id: company.to_param, admin_company: new_attributes}
        expect(response).to redirect_to( new_manager_session_path )
      end
      it "from DELETE #destroy to login page" do
        delete :destroy, params: {id: company.to_param}
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
        # company = Company.create! valid_attributes
        get :index, params: {}, session: valid_session
        expect(response).to be_successful
      end
    end

    describe "GET #show" do
      it "returns a success response" do
        # company = Company.create! valid_attributes
        get :show, params: {id: company.to_param}, session: valid_session
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
        # company = Company.create! valid_attributes
        get :edit, params: {id: company.to_param}, session: valid_session
        expect(response).to be_successful
      end
    end

    describe "POST #create" do
      context "with valid params" do
        it "creates a new Admin::Company" do
          expect {
            post :create, params: {admin_company: valid_attributes}, session: valid_session
          }.to change(Company, :count).by(1)
        end
        it "redirects to the created admin_company" do
          post :create, params: {admin_company: valid_attributes}, session: valid_session
          # expect(response).to redirect_to(Company.last)
          expect(response).to redirect_to( admin_company_path(Company.last) )
        end
      end
      context "with invalid params" do
        it "returns a success response (i.e. to display the 'new' template)" do
          post :create, params: {admin_company: invalid_attributes}, session: valid_session
          expect(response).to be_successful
        end
      end
    end

    describe "PUT #update" do
      context "with valid params" do
        # let(:new_attributes) { {name: "BigCo"} }
        it "updates the requested admin_company" do
          # company = Company.create! valid_attributes
          put :update, params: {id: company.to_param, admin_company: new_attributes}, session: valid_session
          company.reload
          expect( company.name ).to eq( "BigCo" )
        end
        it "redirects to the admin_company" do
          # company = Company.create! valid_attributes
          put :update, params: {id: company.to_param, admin_company: new_attributes}, session: valid_session
          # expect(response).to redirect_to(company)
          expect(response).to redirect_to( admin_company_path(company) )
        end
      end
      context "with invalid params" do
        it "returns a success response (i.e. to display the 'edit' template)" do
          # company = Company.create! valid_attributes
          put :update, params: {id: company.to_param, admin_company: invalid_attributes}, session: valid_session
          expect(response).to be_successful
        end
      end
    end

    describe "DELETE #destroy" do
      it "destroys the requested admin_company" do
        # company = Company.create! valid_attributes
        expect {
          delete :destroy, params: {id: company.to_param}, session: valid_session
        }.to change(Company, :count).by(-1)
      end
      it "redirects to the admin_companies list" do
        # company = Company.create! valid_attributes
        delete :destroy, params: {id: company.to_param}, session: valid_session
        expect(response).to redirect_to(admin_companies_url)
      end
    end
  end

end
