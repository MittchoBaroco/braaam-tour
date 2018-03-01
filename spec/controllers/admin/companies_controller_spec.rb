require 'rails_helper'

RSpec.describe Admin::CompaniesController, type: :controller do

  # This should return the minimal set of attributes required to create a valid
  # Admin::Company. As you add validations to Admin::Company, be sure to
  # adjust the attributes here as well.
  let(:valid_attributes)  {
    FactoryBot.attributes_for(:company)
  }

  let(:invalid_attributes) {
    skip("Add a hash of attributes invalid for your model")
  }

  # This should return the minimal set of values that should be in the session
  # in order to pass any filters (e.g. authentication) defined in
  # Admin::CompaniesController. Be sure to keep this updated too.
  let(:valid_session) { {} }

  describe "GET #index" do
    it "returns a success response" do
      company = Company.create! valid_attributes
      get :index, params: {}, session: valid_session
      expect(response).to be_successful
    end
  end

  describe "GET #show" do
    it "returns a success response" do
      company = Company.create! valid_attributes
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
      company = Company.create! valid_attributes
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
      let(:new_attributes) { {name: "BigCo"} }

      it "updates the requested admin_company" do
        company = Company.create! valid_attributes
        put :update, params: {id: company.to_param, admin_company: new_attributes}, session: valid_session
        company.reload
        expect( company.name ).to eq( "BigCo" )
      end

      it "redirects to the admin_company" do
        company = Company.create! valid_attributes
        put :update, params: {id: company.to_param, admin_company: new_attributes}, session: valid_session
        # expect(response).to redirect_to(company)
        expect(response).to redirect_to( admin_company_path(company) )
      end
    end

    context "with invalid params" do
      it "returns a success response (i.e. to display the 'edit' template)" do
        company = Company.create! valid_attributes
        put :update, params: {id: company.to_param, admin_company: invalid_attributes}, session: valid_session
        expect(response).to be_successful
      end
    end
  end

  describe "DELETE #destroy" do
    it "destroys the requested admin_company" do
      company = Company.create! valid_attributes
      expect {
        delete :destroy, params: {id: company.to_param}, session: valid_session
      }.to change(Company, :count).by(-1)
    end

    it "redirects to the admin_companies list" do
      company = Company.create! valid_attributes
      delete :destroy, params: {id: company.to_param}, session: valid_session
      expect(response).to redirect_to(admin_companies_url)
    end
  end

end
