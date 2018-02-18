require 'rails_helper'

RSpec.describe TourDate, type: :model do

  let!(:tour)               { FactoryBot.create(:tour) }
  let!(:company)            { FactoryBot.create(:company) }
  let(:tour_date)           { FactoryBot.create(:tour_date, tour: tour,
                                                            company: company) }
  let(:invalid_tour_date)   { FactoryBot.build(:invalid_tour_date) }
  let(:no_past_tour_date)   { FactoryBot.build(:no_past_tour_date) }
  let(:duplicate_tour_date) { FactoryBot.build(:tour_date,day: tour_date.day,
                                                          tour: tour_date.tour)}

  context "verify factory" do
    it "correctly builds tour_date" do
      expect( tour_date.valid? ).to be_truthy
      expect( tour_date.errors.details).to eq( {} )
      expect( tour_date.errors.messages).to eq( {} )
    end
    it "correctly detects duplicate_tour_date" do
      expect( duplicate_tour_date.valid? ).to be_falsey
      expect( duplicate_tour_date.errors.messages).to eq(
                  {:tour=>["tours may only have one event per-day"]} )
    end
    it "detects an invalid_tour_date" do
      expect( invalid_tour_date.valid? ).to be_falsey
      expect( invalid_tour_date.errors.messages).to eq(
                  {:tour=>["must exist"], :day=>["is not a valid date"]} )
    end
    it "detects an no_past_tour_date" do
      expect( no_past_tour_date.valid? ).to be_falsey
      expect( no_past_tour_date.errors.messages).to eq(
                  { :day=>["must be a date on or after today"]} )
    end
  end

  context "Check tour_date Relationships" do
    it "tour_date can find their associated tour" do
      expect( tour_date.tour ).to eq( tour )
    end
    it "tour_date can find their associated company" do
      expect( tour_date.company ).to eq( company )
    end
  end

end
