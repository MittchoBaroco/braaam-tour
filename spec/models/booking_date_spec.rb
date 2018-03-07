require 'rails_helper'

RSpec.describe BookingDate, type: :model do

  let!(:tour)               { FactoryBot.create(:tour) }
  let!(:company)            { FactoryBot.create(:company) }
  let!(:booking_day_0)      { FactoryBot.create(:booking_date,
                                              day: Date.today,
                                              tour: tour,
                                              company: company) }
  let(:invalid_booking_date){ FactoryBot.build(:invalid_booking_date) }
  let(:no_past_booking_date){ FactoryBot.build(:no_past_booking_date) }
  let!(:copy_booking_day_0) { FactoryBot.build(:booking_date,
                                              day: Date.today,
                                              tour_id: tour.id)}
  let!(:tour_tomorrow)      { FactoryBot.create(:tour, title: "Tomorrow") }
  let!(:booking_day_1)      { FactoryBot.create(:booking_date,
                                              day: Date.tomorrow,
                                              tour_id: tour_tomorrow.id) }
  let!(:tour_in_week)       { FactoryBot.create(:tour, title: "In a Week") }
  let!(:booking_day_7)      { FactoryBot.create(:booking_date,
                                              day: (Date.today + 7),
                                              tour_id: tour_in_week.id) }
  let!(:tour_today_tomorrow){ FactoryBot.create(:tour, title: "TodayTomorrow") }
  let!(:booking_day_tt_0)   { FactoryBot.create(:booking_date,
                                              day: Date.today,
                                              tour_id: tour_today_tomorrow.id) }
  let!(:booking_day_tt_1)   { FactoryBot.create(:booking_date,
                                              day: Date.tomorrow,
                                              tour_id: tour_today_tomorrow.id) }

  context "verify factory" do
    it 'has a valid Factory' do
      expect(booking_day_0).to be_valid
    end
    it 'has a valid booked factory' do
      expect(booking_day_0).to be_valid
      expect(booking_day_0.company).to_not be_nil
      expect(booking_day_0.company).to eq( company )
    end
  end

  context "Check booking_date validations" do
    it "correctly detects duplicate_booking_date" do
      # pp booking_day_0
      # pp copy_booking_day_0
      expect( copy_booking_day_0.valid? ).to be_falsey
      expect( copy_booking_day_0.errors.messages).to eq(
                  {:tour=>["tours may only have one event per-day"]} )
    end

    it "detects an invalid_booking_date" do
      expect( invalid_booking_date.valid? ).to be_falsey
      expect( invalid_booking_date.errors.messages).to eq(
                  {:tour=>["must exist"], :day=>["is not a valid date"]} )
    end

    it "detects an no_past_booking_date" do
      expect( no_past_booking_date.valid? ).to be_falsey
      expect( no_past_booking_date.errors.messages).to eq(
                  { :day=>["must be a date on or after today"]} )
    end
  end

  context "Check booking_date Relationships" do
    it { should belong_to(:tour) }
    it { should belong_to(:company).optional }
  end

  context "test scopes" do
    it "properly selects and orders future booking dates for events" do
      response = BookingDate.future.pluck(:id)
      correct  = [booking_day_1.id, booking_day_tt_1.id,
                  booking_day_7.id]
      expect(response).to eq( correct )
    end
    it "properly selects and orders current booking dates for events" do
      response = BookingDate.current.pluck(:id)
      correct  = [booking_day_0.id, booking_day_tt_0.id, booking_day_1.id,
                  booking_day_tt_1.id, booking_day_7.id]
      expect(response).to eq( correct )
    end
    it "properly selects and orders dates after TOMORROW" do
      response = BookingDate.after(Date.tomorrow).pluck(:id)
      correct  = [ booking_day_7.id ]
      expect(response).to eq( correct )
    end
    it "properly selects and orders dates before TOMORROW" do
      response = BookingDate.before(Date.tomorrow).pluck(:id)
      correct  = [ booking_day_tt_0.id, booking_day_0.id ]
      expect(response).to eq( correct )
    end
    it "properly selects and orders past dates"

  end

end
