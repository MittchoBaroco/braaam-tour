require 'rails_helper'

RSpec.describe Admin::CommentsController, type: :controller do

  include Devise::Test::ControllerHelpers

  # test attributes
  let!(:tour) {
    FactoryBot.create(:tour)
  }
  let!(:comment) {
    FactoryBot.create(:comment)
  }
  let(:new_attributes) {
    {comment_body: "GREAT"}
  }
  let(:valid_attributes) {
    FactoryBot.attributes_for(:comment, tour_id: tour.id)
  }
  let(:invalid_attributes) {
    { comment_body: "", author_name: "", tour_id: "" }
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
        get :edit, params: {id: comment.to_param}
        expect(response).to redirect_to( new_manager_session_path )
      end
      it "from POST #create to login page" do
        post :create, params: {admin_comment: invalid_attributes}
        expect(response).to redirect_to( new_manager_session_path )
      end
      it "from PUT #show to login page" do
        put :update, params: {id: comment.to_param, admin_comment: new_attributes}
        expect(response).to redirect_to( new_manager_session_path )
      end
      it "from PATCH #show to login page" do
        patch :update, params: {id: comment.to_param, admin_comment: new_attributes}
        expect(response).to redirect_to( new_manager_session_path )
      end
      it "from DELETE #destroy to login page" do
        delete :destroy, params: {id: comment.to_param}
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
        get :show, params: {id: comment.to_param}, session: valid_session
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
        get :edit, params: {id: comment.to_param}, session: valid_session
        expect(response).to be_successful
      end
    end

    describe "POST #create" do
      context "with valid params" do
        it "creates a new Comment via Admin Panels" do
          # pp valid_attributes
          expect {
            post :create, params: {admin_comment: valid_attributes}, session: valid_session
          }.to change(Comment, :count).by(1)
        end

        it "redirects to the created admin_comment" do
          # pp valid_attributes
          post :create, params: {admin_comment: valid_attributes}, session: valid_session
          expect(response).to redirect_to( admin_comment_path(Comment.last) )
        end
      end

      context "with invalid params" do
        it "returns a success response (i.e. to display the 'new' template)" do
          post :create, params: {admin_comment: invalid_attributes}, session: valid_session
          expect(response).to be_successful
        end
      end
    end

    describe "PUT #update" do
      context "with valid params" do
        it "updates the requested admin_comment" do
          put :update, params: {id: comment.to_param, admin_comment: new_attributes}, session: valid_session
          comment.reload
          expect(comment.comment_body).to eq("GREAT")
        end
        it "redirects to the admin_comment" do
          put :update, params: {id: comment.to_param, admin_comment: valid_attributes}, session: valid_session
          expect(response).to redirect_to( admin_comment_path(comment) )
        end
      end
      context "with invalid params" do
        it "returns a success response (i.e. to display the 'edit' template)" do
          put :update, params: {id: comment.to_param, admin_comment: invalid_attributes}, session: valid_session
          expect(response).to be_successful
        end
      end
    end

    describe "DELETE #destroy" do
      it "destroys the requested admin_comment" do
        expect {
          delete :destroy, params: {id: comment.to_param}, session: valid_session
        }.to change(Comment, :count).by(-1)
      end
      it "redirects to the admin_comments list" do
        delete :destroy, params: {id: comment.to_param}, session: valid_session
        expect(response).to redirect_to(admin_comments_url)
      end
    end
  end

end
