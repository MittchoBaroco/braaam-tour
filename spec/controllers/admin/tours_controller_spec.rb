require 'rails_helper'

RSpec.describe Admin::ToursController, type: :controller do

  # This should return the minimal set of attributes required to create a valid
  # Admin::Tour. As you add validations to Admin::Tour, be sure to
  # adjust the attributes here as well.
  let(:valid_attributes) {
    FactoryBot.attributes_for(:tour)
  }

  let(:invalid_attributes) {
      FactoryBot.attributes_for(:tour, title: "", price_braaam: -100)
  }

  # This should return the minimal set of values that should be in the session
  # in order to pass any filters (e.g. authentication) defined in
  # Admin::ToursController. Be sure to keep this updated too.
  let!(:valid_session) {
      manager = FactoryBot.create(:manager)
      {manager_id: manager.id}
    }

  describe "GET #index" do
    it "returns a success response" do
      tour = Tour.create! valid_attributes
      get :index, params: {}, session: valid_session
      expect(response).to be_successful
    end
  end

  describe "GET #show" do
    it "returns a success response" do
      tour = Tour.create! valid_attributes
      get :show, params: {id: tour.to_param}, session: valid_session
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
      tour = Tour.create! valid_attributes
      get :edit, params: {id: tour.to_param}, session: valid_session
      expect(response).to be_successful
    end
  end

  describe "POST #create" do
    context "with valid params" do
      it "creates a new Admin::Tour" do
        expect {
          post :create, params: {admin_tour: valid_attributes}, session: valid_session
        }.to change(Tour, :count).by(1)
      end

      it "redirects to the created admin_tour" do
        post :create, params: {admin_tour: valid_attributes}, session: valid_session
        # expect(response).to redirect_to(Tour.last)
        expect(response).to redirect_to( admin_tour_path(Tour.last) )
      end
    end

    context "with invalid params" do
      it "returns a success response (i.e. to display the 'new' template)" do
        post :create, params: {admin_tour: invalid_attributes}, session: valid_session
        expect(response).to be_successful
      end
    end
  end

  describe "PUT #update" do
    context "with valid params" do
      let(:new_attributes) { {title: "Watch Out"} }

      it "updates the requested admin_tour" do
        tour = Tour.create! valid_attributes
        put :update, params: {id: tour.to_param, admin_tour: new_attributes}, session: valid_session
        tour.reload
        expect( tour.title ).to eq( "Watch Out" )
      end

      it "redirects to the admin_tour" do
        tour = Tour.create! valid_attributes
        put :update, params: {id: tour.to_param, admin_tour: valid_attributes}, session: valid_session
        # expect(response).to redirect_to(tour)
        expect(response).to redirect_to( admin_tour_path(tour) )
      end
    end

    context "with invalid params" do
      it "returns a success response (i.e. to display the 'edit' template)" do
        tour = Tour.create! valid_attributes
        put :update, params: {id: tour.to_param, admin_tour: invalid_attributes}, session: valid_session
        expect(response).to be_successful
      end
    end
  end

  describe "DELETE #destroy" do
    it "destroys the requested admin_tour" do
      tour = Tour.create! valid_attributes
      expect {
        delete :destroy, params: {id: tour.to_param}, session: valid_session
      }.to change(Tour, :count).by(-1)
    end

    it "redirects to the admin_tours list" do
      tour = Tour.create! valid_attributes
      delete :destroy, params: {id: tour.to_param}, session: valid_session
      expect(response).to redirect_to(admin_tours_url)
    end
  end

end
