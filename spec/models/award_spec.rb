require 'rails_helper'

RSpec.describe Award, type: :model do

  let!(:award)         { FactoryBot.create(:award) }
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
      # pp award
      # pp duplicate_award
      expect( duplicate_award.valid? ).to be_falsey
      pp duplicate_award.errors.messages
      # expect( duplicate_award.errors.details[:award_name][0][:error]).to eq( :taken )
      expect( duplicate_award.errors.messages).to eq(
                                {:caption=>["award must be unique in fields: caption, award_year and institution"]} )
    end
    it "detects an invalid_award" do
      expect( invalid_award.valid? ).to be_falsey
      # expect( invalid_award.errors.details).to eq(
      #             {:name=>[{:error=>:blank},
      #                               {:error=>:too_short, :count=>2}]})
      expect( invalid_award.errors.messages).to eq(
                  { :tour=>["must exist"],
                    :caption=>[   "can't be blank",
                                  "is too short (minimum is 2 characters)"],
                    :institution=>["can't be blank",
                                  "is too short (minimum is 2 characters)"],
                    :award_year=>["can't be blank",
                                  "is too short (minimum is 2 characters)"]
                  } )
    end
  end

  xcontext "Check award Relationships" do
    it "award can find their associated dates" do
      expect( award.event_dates ).to eq( [event_dates] )
    end
    it "award can find their associated events" do
      expect( award.events ).to eq( [events] )
    end
  end
end
