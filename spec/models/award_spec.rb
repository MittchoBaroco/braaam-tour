require 'rails_helper'

RSpec.describe Award, type: :model do

  let!(:tour)          { FactoryBot.create(:tour) }
  let!(:award)         { FactoryBot.create(:award,tour: tour) }
  let!(:double_award)  { FactoryBot.build(:award, tour: tour,
                                                  award_year: 1940.5) }
  let!(:too_old_award) { FactoryBot.build(:award, tour: tour,
                                                  award_year: 1940) }
  let(:invalid_award)  { FactoryBot.build(:invalid_award) }
  let(:duplicate_award){ FactoryBot.build(:award,caption: award.caption,
                                                institution: award.institution,
                                                award_year: award.award_year
                                          ) }
  context "verify factory" do
    it "correctly builds award" do
      expect( award.valid? ).to be_truthy
      expect( award.errors.details).to eq( {} )
      expect( award.errors.messages).to eq( {} )
    end
    it "correctly detects duplicate_award" do
      expect( duplicate_award.valid? ).to be_falsey
      expect( duplicate_award.errors.messages).to eq(
                                {:caption=>["award must be unique in fields: caption, award_year and institution"]} )
    end
    it "detects an invalid_award" do
      expect( invalid_award.valid? ).to be_falsey
      expect( invalid_award.errors.messages).to eq(
                  { :tour=>["must exist"],
                    :caption=>[   "can't be blank",
                                  "is too short (minimum is 2 characters)"],
                    :institution=>["can't be blank",
                                  "is too short (minimum is 2 characters)"],
                    :award_year=>["can't be blank",
                                  "year must be numeric and greater than or equal to 2000"] } )
    end
    it "detects an too_old_award" do
      expect( too_old_award.valid? ).to be_falsey
      expect( too_old_award.errors.messages).to eq(
                  { :award_year=>["year must be numeric and greater than or equal to 2000"] } )
    end
    it "detects an double_award" do
      expect( double_award.valid? ).to be_falsey
      expect( double_award.errors.messages).to eq(
                  { :award_year=>["year must be numeric and greater than or equal to 2000"] } )
    end
  end

  context "Check award Relationships" do
    it "award can find their associated tour" do
      expect( award.tour ).to eq( tour )
    end
  end
end
