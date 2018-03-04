require 'rails_helper'

RSpec.describe TourBookingDate, type: :model do

  let!(:tour)               { FactoryBot.create(:tour) }
  let!(:company)            { FactoryBot.create(:company) }
  let(:tour_booking_date)           { FactoryBot.create(:tour_booking_date, tour: tour,
                                                            company: company) }
  let(:booked_date)         { FactoryBot.create(:tour_booking_date, :booked)}
  let(:invalid_tour_booking_date)   { FactoryBot.build(:invalid_tour_booking_date) }
  let(:no_past_tour_booking_date)   { FactoryBot.build(:no_past_tour_booking_date) }
  let(:duplicate_tour_booking_date) { FactoryBot.build(:tour_booking_date,day: tour_booking_date.day,
                                                          tour: tour_booking_date.tour)}

  context "verify factory" do
    it 'has a valid Factory' do
      expect(tour_booking_date).to be_valid
    end

    it 'has a valid booked factory' do
      expect(booked_date).to be_valid
      expect(booked_date.company).to_not be_nil
    end
  end

  context "Check tour_booking_date validations" do
    it "correctly detects duplicate_tour_booking_date" do
      expect( duplicate_tour_booking_date.valid? ).to be_falsey
      expect( duplicate_tour_booking_date.errors.messages).to eq(
                  {:tour=>["tours may only have one event per-day"]} )
    end

    it "detects an invalid_tour_booking_date" do
      expect( invalid_tour_booking_date.valid? ).to be_falsey
      expect( invalid_tour_booking_date.errors.messages).to eq(
                  {:tour=>["must exist"], :day=>["is not a valid date"]} )
    end

    it "detects an no_past_tour_booking_date" do
      expect( no_past_tour_booking_date.valid? ).to be_falsey
      expect( no_past_tour_booking_date.errors.messages).to eq(
                  { :day=>["must be a date on or after today"]} )
    end
  end

  context "Check tour_booking_date Relationships" do
    it { should belong_to(:tour) }
    it { should belong_to(:company).optional }
  end

end
