require 'rails_helper'

RSpec.describe Admin::ToursController, type: :controller do
  include Devise::Test::ControllerHelpers
  let!(:manager) { FactoryBot.create(:manager) }

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
  let!(:tour)          { FactoryBot.create(:tour) }
  # these are new - adding dependencies to test deletes
  let!(:valid_session) { {manager_id: manager.id} }

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
      it "from GET #edit to login page" do
        get :edit, params: {id: tour.to_param}
        expect(response).to redirect_to( new_manager_session_path )
      end
      it "from POST #create to login page" do
        post :create, params: {tour: valid_attributes}
        expect(response).to redirect_to( new_manager_session_path )
      end
      it "from PUT #update to login page" do
        put :update, params: {id: tour.to_param, tour: valid_attributes}
        expect(response).to redirect_to( new_manager_session_path )
      end
      it "from PATCH #update to login page" do
        patch :update, params: {id: tour.to_param, tour: valid_attributes}
        expect(response).to redirect_to( new_manager_session_path )
      end
      it "from PUT #highlight to login page" do
        put :highlight, params: {id: tour.to_param, tour: valid_attributes}
        expect(response).to redirect_to( new_manager_session_path )
      end
      it "from PATCH #highlight to login page" do
        patch :highlight, params: {id: tour.to_param, tour: valid_attributes}
        expect(response).to redirect_to( new_manager_session_path )
      end
      it "from DELETE #destroy to login page" do
        delete :destroy, params: {id: tour.to_param}
        expect(response).to redirect_to( new_manager_session_path )
      end
    end
  end

  context "AUTHENTICATED as manager" do
    let!(:booking_date)  { FactoryBot.create(:booking_date, tour_id: tour.id) }
    let!(:booked_date)   { FactoryBot.create(:booked_date,  tour_id: tour.id) }
    let!(:award)         { FactoryBot.create(:award,        tour_id: tour.id) }

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
    # https://www.neontsunami.com/posts/testing-activestorage-uploads-in-rails-52
    describe 'POST #update - with ActiveStorage image' do
      fit 'attaches the uploaded file' do
        file = fixture_file_upload( Rails.root.
                        join('public', 'apple-touch-icon.png'), 'image/png')
        expect {
          tour_params = FactoryBot.attributes_for(:tour, cover_image: file)
          post :create, params: { tour: tour_params },
                      session: valid_session
        }.to change(ActiveStorage::Attachment, :count).by(1)
      end
    end
    describe "POST #create" do
      context "with valid params" do
        fit "creates a new Tour from Admin" do
          expect {
            post :create, params: {tour: valid_attributes},
                          session: valid_session
          }.to change(Tour, :count).by(1)
        end
        fit "redirects to the created tour" do
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
        file = fixture_file_upload( Rails.root.
                        join('spec', 'photos', 'RubyRules.png'), 'image/png')
        put :update, params: {id: tour.to_param,
                              tour: { cover_image: file } },
                      session: valid_session
        tour.reload
        expect(tour.cover_image.filename ).to eq('RubyRules.png')
      end
    end
    fdescribe 'PUT #update - with ActiveStorage tech_sheet' do
      fit 'attaches the uploaded file' do
        file = fixture_file_upload( Rails.root.
                        join('spec', 'photos', 'Checkout.pdf'), 'application/pdf')
        put :update, params: {id: tour.to_param,
                              tour: { tech_sheet: file } },
                      session: valid_session
        tour.reload
        expect(tour.tech_sheet.filename ).to eq('Checkout.pdf')
      end
    end
    describe "PUT #update" do
      context "with valid params" do
        it "updates the requested tour" do
          put :update, params: {id: tour.to_param, tour: new_attributes},
                        session: valid_session
          tour.reload
          expect( tour.title ).to eq( "Watch" )
        end
        fit "redirects to the tour" do
          put :update, params: {id: tour.to_param, tour: valid_attributes},
                        session: valid_session
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
    describe "PUT #highlight" do
      it "marks the tour as highlighted" do
        put :highlight, params: {id: tour.to_param, tour: new_attributes},
                      session: valid_session
        tour.reload
        expect( tour.highlighted_at ).not_to be_blank
      end
      it "redirects to the tour" do
        put :highlight, params: {id: tour.to_param, tour: valid_attributes},
                      session: valid_session
        expect(response).to redirect_to( admin_tour_path(tour) )
      end
    end
    describe "DELETE #destroy" do
      it "destroys the requested tour" do
        expect {
          delete :destroy, params: {id: tour.to_param}, session: valid_session
        }.to change(Tour, :count).by(-1)
      end
      it "redirects to the tours list" do
        # tour = Tour.create! valid_attributes
        delete :destroy, params: {id: tour.to_param}, session: valid_session
        expect(response).to redirect_to(admin_tours_url)
      end
    end

  end

end
