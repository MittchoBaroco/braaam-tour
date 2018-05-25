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

    it { should validate_presence_of(:comment_body) }

    it { should validate_length_of(:author_name).is_at_least(2).allow_nil }
    it { should validate_length_of(:comment_body).is_at_least(3) }

  end

  context "Check Relationships" do
    it { should belong_to(:tour) }
    it { should belong_to(:company).optional }
  end

  context "Check Methods" do
    it "return author_name if there is not company link to it" do
      comment_dup = comment.dup
      comment_dup.author_name = "yolo"
      expect(comment_dup.author_name).to eq("yolo")
    end

    it "return the company name if there is a Relationship" do
      company = FactoryBot.create(:company)
      comment_dup = comment.dup
      comment_dup.company = company
      expect(comment_dup.author_name).to eq(company.name)
    end
  end

end
