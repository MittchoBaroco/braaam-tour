require 'rails_helper'

RSpec.describe Company, type: :model do

    let!(:tour)         { FactoryBot.create(:tour) }
    let!(:company)      { FactoryBot.create(:company) }
    let!(:tour_date)    { FactoryBot.create(:tour_date, tour: tour,
                                                        company: company) }

    let(:invalid_company)   { FactoryBot.build(:invalid_company) }
    let(:duplicate_company) { FactoryBot.build(:company, email: company.email) }

    context "verify factory" do
      it "correctly builds company" do
        expect( company.valid? ).to be_truthy
        expect( company.errors.details).to eq( {} )
        expect( company.errors.messages).to eq( {} )
      end
      it "correctly detects duplicate_company" do
        expect( duplicate_company.valid? ).to be_falsey
        expect( duplicate_company.errors.messages).to eq(
                                  {:email=>["has already been taken"]} )
      end
      it "detects an invalid_company" do
        expect( invalid_company.valid? ).to be_falsey
        expect( invalid_company.errors.messages).to eq(
                    { :email=>[ "can't be blank",
                                "is too short (minimum is 2 characters)"],
                      :name=>["can't be blank",
                              "is too short (minimum is 2 characters)"]
                    } )
      end
    end

    context "Check company Relationships" do
      it "company can find their associated dates" do
        expect( company.tour_dates ).to eq( [tour_date] )
      end
      it "company can find their associated events" do
        expect( company.tours ).to eq( [tour] )
      end
    end

end
