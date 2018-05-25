require 'rails_helper'

RSpec.describe CommentsController, type: :controller do
  before(:each) do
    sign_in company
  end

  let!(:company) {
    FactoryBot.create(:company, email: 'test@example.com')
  }

  let!(:tour) {
    FactoryBot.create(:tour)
  }

  let!(:valid_attributes){
    {comment_body: "yolo"}
  }

  let!(:valid_session){{}}

  describe "GET #create" do
    context "with valid params" do
      it "creates a new comment" do
        expect {
          post :create, params: {comment: valid_attributes, tour_id: tour.id},
                        session: valid_session
        }.to change(Comment, :count).by(1)
      end
    end
  end

end
