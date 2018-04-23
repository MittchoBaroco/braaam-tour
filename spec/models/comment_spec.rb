require 'rails_helper'

RSpec.describe Comment, type: :model do

  let!(:comment)      { FactoryBot.create(:comment) }

  context "verify factory" do
    it 'has a valid Factory' do
      expect(comment).to be_valid
    end
  end

  context "Check company validations" do

    # it { should validate_uniqueness_of(:comment_body).
    #         scoped_to(:author_name, :tour_id).case_insensitive }

    it { should validate_presence_of(:author_name) }
    it { should validate_presence_of(:comment_body) }

    it { should validate_length_of(:author_name).is_at_least(2) }
    it { should validate_length_of(:comment_body).is_at_least(3) }

  end

  context "Check Relationships" do
    it { should belong_to(:tour) }
  end

end
