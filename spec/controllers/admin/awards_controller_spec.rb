require 'rails_helper'

RSpec.describe Admin::AwardsController, type: :controller do

  # This should return the minimal set of attributes required to create a valid
  # Admin::Award. As you add validations to Admin::Award, be sure to
  # adjust the attributes here as well.
  let!(:tour) {
    FactoryBot.create(:tour)
  }
  let(:valid_attributes) {
    FactoryBot.attributes_for(:award, tour_id: tour.id)
  }
  let(:invalid_attributes) {
    { caption: "", institution: "", country: "", award_year: "", tour_id: "" }
  }

  # This should return the minimal set of values that should be in the session
  # in order to pass any filters (e.g. authentication) defined in
  # Admin::AwardsController. Be sure to keep this updated too.
  let(:valid_session) { {} }

  describe "GET #index" do
    it "returns a success response" do
      award = Award.create! valid_attributes
      get :index, params: {}, session: valid_session
      expect(response).to be_successful
    end
  end

  describe "GET #show" do
    it "returns a success response" do
      award = Award.create! valid_attributes
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
      award = Award.create! valid_attributes
      get :edit, params: {id: award.to_param}, session: valid_session
      expect(response).to be_successful
    end
  end

  describe "POST #create" do
    context "with valid params" do
      it "creates a new Admin::Award" do
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
      let(:new_attributes) {
        {caption: "GREAT"}
      }

      it "updates the requested admin_award" do
        award = Award.create! valid_attributes
        put :update, params: {id: award.to_param, admin_award: new_attributes}, session: valid_session
        award.reload
        expect(award.caption).to eq("GREAT")
      end

      it "redirects to the admin_award" do
        award = Award.create! valid_attributes
        put :update, params: {id: award.to_param, admin_award: valid_attributes}, session: valid_session
        expect(response).to redirect_to( admin_award_path(award) )
      end
    end

    context "with invalid params" do
      it "returns a success response (i.e. to display the 'edit' template)" do
        award = Award.create! valid_attributes
        put :update, params: {id: award.to_param, admin_award: invalid_attributes}, session: valid_session
        expect(response).to be_successful
      end
    end
  end

  describe "DELETE #destroy" do
    it "destroys the requested admin_award" do
      award = Award.create! valid_attributes
      expect {
        delete :destroy, params: {id: award.to_param}, session: valid_session
      }.to change(Award, :count).by(-1)
    end

    it "redirects to the admin_awards list" do
      award = Award.create! valid_attributes
      delete :destroy, params: {id: award.to_param}, session: valid_session
      expect(response).to redirect_to(admin_awards_url)
    end
  end

end
