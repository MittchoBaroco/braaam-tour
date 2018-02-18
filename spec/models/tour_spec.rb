require 'rails_helper'

RSpec.describe Tour, type: :model do

  let!(:tour)         { FactoryBot.create(:tour) }
  let(:invalid_tour)  { FactoryBot.build(:invalid_tour) }
  let(:negative_tour) { FactoryBot.build(:negative_tour) }
  let!(:award)        { FactoryBot.create(:award, tour: tour) }

  context "verify factory" do
    it "correctly builds tour" do
      expect( tour.valid? ).to be_truthy
      expect( tour.errors.details).to eq( {} )
      expect( tour.errors.messages).to eq( {} )
    end
    it "correctly detects negative_tour" do
      expect( negative_tour.valid? ).to be_falsey
      expect( negative_tour.errors.messages).to eq(
                  { :price_braaam=>["must be greater than or equal to 0"],
                    :price_normal=>["must be greater than or equal to 0"]
                  } )
    end
    it "detects an invalid_tour" do
      expect( invalid_tour.valid? ).to be_falsey
      expect( invalid_tour.errors.messages).to eq(
                  { :title=>["can't be blank", "is too short (minimum is 2 characters)"],
                    :description=>["can't be blank", "is too short (minimum is 2 characters)"],
                    :video_uri=>["can't be blank", "is too short (minimum is 2 characters)"],
                    :tech_help=>["is not included in the list"],
                    :housing=>["is not included in the list"],
                    :catering=>["is not included in the list"],
                    :transport=>["is not included in the list"],
                  } )
    end
  end

  context "Check tour Relationships" do
    it "tour can find their associated awards" do
      expect( tour.awards ).to eq( [award] )
    end
    xit "tour can find their associated tour_dates" do
      expect( tour.tour_dates ).to eq( [tour_dates] )
    end
    xit "tour can find their associated companies (through dates)" do
      expect( tour.companies ).to eq( [companies] )
    end
  end

end
