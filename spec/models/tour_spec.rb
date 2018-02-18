require 'rails_helper'

RSpec.describe Tour, type: :model do

  let!(:tour)         { FactoryBot.create(:tour) }
  let!(:company)      { FactoryBot.create(:company) }
  let!(:award)        { FactoryBot.create(:award, tour: tour) }
  let!(:tour_date)    { FactoryBot.create(:tour_date, tour: tour,
                                                      company: company) }

  let(:invalid_tour)  { FactoryBot.build(:invalid_tour) }
  let(:negative_tour) { FactoryBot.build(:negative_tour) }

  let!(:awarded_tour) {   FactoryBot.create(:tour) }
  let!(:awards)       { [ FactoryBot.create(:award, tour: awarded_tour),
                          FactoryBot.create(:award, tour: awarded_tour) ] }
  let!(:tour_dates)   { [ FactoryBot.create(:tour_date, tour: awarded_tour),
                          FactoryBot.create(:tour_date, tour: awarded_tour) ] }

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
    it "tour can find its associated award" do
      expect( tour.awards ).to eq( [award] )
    end
    it "awarded_tour can find their associated awards" do
      expect( awarded_tour.awards ).to eq( awards )
    end
    it "tour can find its associated tour_date" do
      expect( tour.tour_dates ).to eq( [tour_date] )
    end
    it "awarded_tour can find their associated tour_dates" do
      expect( awarded_tour.tour_dates ).to eq( tour_dates )
    end
    it "tour can find their associated companies (through dates)" do
      expect( tour.companies ).to eq( [company] )
    end
  end

end
