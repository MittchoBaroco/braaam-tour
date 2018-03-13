require 'rails_helper'

RSpec.describe Admin::ToursController, type: :controller do

  # include Devise::TestHelpers             # deprecated
  include Devise::Test::ControllerHelpers

  # test attributes
  let(:new_attributes) {
    {title: "Watch"}
  }
  let(:valid_attributes) {
    FactoryBot.attributes_for(:tour)
  }
  let(:invalid_attributes) {
      FactoryBot.attributes_for(:tour, title: "", price_braaam: -100)
  }
  # user & session - for security / authorization testing
  let!(:tour) { FactoryBot.create(:tour) }
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
        get :edit, params: {id: tour.to_param}
        expect(response).to redirect_to( new_manager_session_path )
      end
      it "from POST #create to login page" do
        post :create, params: {tour: invalid_attributes}
        expect(response).to redirect_to( new_manager_session_path )
      end
      it "from PUT #show to login page" do
        put :update, params: {id: tour.to_param, tour: new_attributes}
        expect(response).to redirect_to( new_manager_session_path )
      end
      it "from PATCH #show to login page" do
        patch :update, params: {id: tour.to_param, tour: new_attributes}
        expect(response).to redirect_to( new_manager_session_path )
      end
      it "from DELETE #destroy to login page" do
        delete :destroy, params: {id: tour.to_param}
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
        get :edit, params: {id: tour.to_param}, session: valid_session
        expect(response).to be_successful
      end
    end
    describe "POST #create" do
      context "with valid params" do
        it "creates a new Tour from Admin" do
          expect {
            post :create, params: {tour: valid_attributes},
                          session: valid_session
          }.to change(Tour, :count).by(1)
        end
        it "redirects to the created admin_tour" do
          post :create, params: {tour: valid_attributes},
                        session: valid_session
          # expect(response).to redirect_to(Tour.last)
          expect(response).to redirect_to( admin_tour_path(Tour.last) )
        end
      end
      context "with invalid params" do
        it "returns a success response (displays the 'new' template)" do
          post :create, params: {tour: invalid_attributes},
                        session: valid_session
          expect(response).to be_successful
        end
      end
    end
    # https://www.neontsunami.com/posts/testing-activestorage-uploads-in-rails-52
    describe 'PUT #update - with ActiveStorage image' do
      it 'attaches the uploaded file' do
        file = fixture_file_upload(
          Rails.root.join('public', 'apple-touch-icon.png'), 'image/png')
        expect {
          put :update, params: {id: tour.to_param,
                                tour: { cover_image: file } },
                      session: valid_session
        }.to change(ActiveStorage::Attachment, :count).by(1)
      end
    end
    describe "PUT #update" do
      context "with valid params" do
        it "updates the requested admin_tour" do
          put :update, params: {id: tour.to_param, tour: new_attributes},
                        session: valid_session
          tour.reload
          expect( tour.title ).to eq( "Watch" )
        end
        it "redirects to the admin_tour" do
          put :update, params: {id: tour.to_param, tour: valid_attributes},
                        session: valid_session
          # expect(response).to redirect_to(tour)
          expect(response).to redirect_to( admin_tour_path(tour) )
        end
      end
      context "with invalid params" do
        it "returns a success response (i.e. to display the 'edit' template)" do
          put :update, params: {id: tour.to_param, tour: invalid_attributes},
                        session: valid_session
          expect(response).to be_successful
        end
      end
    end
    describe "DELETE #destroy" do
      it "destroys the requested admin_tour" do
        expect {
          delete :destroy, params: {id: tour.to_param}, session: valid_session
        }.to change(Tour, :count).by(-1)
      end
      it "redirects to the admin_tours list" do
        # tour = Tour.create! valid_attributes
        delete :destroy, params: {id: tour.to_param}, session: valid_session
        expect(response).to redirect_to(admin_tours_url)
      end
    end

  end

end
