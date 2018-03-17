require 'rails_helper'

RSpec.describe Tour, type: :model do

  let!(:tour_in_week_awards){ FactoryBot.create(:tour, title: "In Week") }
  let!(:tour_today_tomorrow){ FactoryBot.create(:tour, title: "Today & Tomorrow") }
  let!(:tour_tomorrow)      { FactoryBot.create(:tour, title: "Tomorrow") }
  let!(:tour_today)         { FactoryBot.create(:tour, title: "Today") }
  # let!(:tour_yesterday)   { FactoryBot.create(:tour, title: "Yesterday") }

  let!(:date_in_week)       { FactoryBot.create(:booking_date,
                                                day: (Date.today + 7),
                                                tour_id: tour_in_week_awards.id) }
  let!(:date_tt_tomorrow)   { FactoryBot.create(:booking_date,
                                                day: (Date.tomorrow),
                                                tour_id: tour_today_tomorrow.id) }
  let!(:date_tt_today)      { FactoryBot.create(:booking_date,
                                                day: (Date.today),
                                                tour_id: tour_today_tomorrow.id) }
  let!(:date_tomorrow)      { FactoryBot.create(:booking_date,
                                                day: (Date.tomorrow),
                                                tour_id: tour_tomorrow.id) }
  let!(:date_today)         { FactoryBot.create(:booking_date,
                                                day: (Date.today),
                                                tour_id: tour_today.id) }
  # let!(:date_yesterday)   { FactoryBot.create(:booking_date,
  #                                             day: (Date.yesterday),
  #                                             tour_id: tour_yesterday.id) }
  context "verify factories" do
    it 'has a valid Factory' do
      expect(tour_today).to be_valid
    end
    it 'has a valid Factory with awards' do
      expect(tour_in_week_awards).to be_valid
    end
  end

  context "Check company validations" do
    it { should validate_presence_of(:title) }
    it { should validate_presence_of(:description) }
    # it { should validate_presence_of(:video_uri) }

    it { should validate_length_of(:title).is_at_least(2) }
    it { should validate_length_of(:description).is_at_least(2) }
    # it { should validate_length_of(:video_uri).is_at_least(2) }

    it { should allow_value(%w(true false)).for(:tech_help) }
    it { should allow_value(%w(true false)).for(:housing) }
    it { should allow_value(%w(true false)).for(:catering) }
    it { should allow_value(%w(true false)).for(:transport) }

    it { should allow_values('',  nil, 'http://foo.com',
                                  'http://foo.com/',
                                  'http://foo.com/sd_fgh?sdfg=ertyui').
                                  for(:video_uri) }
    it { should_not allow_values( 'http://foo.com/sd fgh?sdfg=ertyui',
                                  'http://foo',
                                  'buz', ).
                                  for(:video_uri) }

    # money is not working with shoulda
    it "invalidated normal_price with 0" do
      invalid_tour = tour_today.dup
      invalid_tour.price_normal = -1
      expect(invalid_tour).to_not be_valid
    end
    it "invalidated braaam_price with 0" do
      invalid_tour = tour_today.dup
      invalid_tour.price_braaam = -1
      expect(invalid_tour).to_not be_valid
    end
  end

  context "Check company Relationships" do
    it { should have_many(:awards) }
    it { should have_many(:booking_dates) }
    it { should have_many(:companies).through(:booking_dates) }
  end

  context "test nested attributes" do
    it { should accept_nested_attributes_for(:awards) }
    it { should accept_nested_attributes_for(:booking_dates) }
  end

  context "test scopes" do
    it "properly selects and orders future tours" do
      response = Tour.future.pluck(:title)
      correct  = [tour_today_tomorrow.title, tour_tomorrow.title, tour_in_week_awards.title ]
      expect(response).to eq( correct )
    end
    it "properly selects and orders current (today or future) tours" do
      response = Tour.current.pluck(:title)
      correct  = [tour_today_tomorrow.title, tour_today.title, tour_tomorrow.title, tour_in_week_awards.title ]
      expect(response).to eq( correct )
    end
    it "properly selects and orders tours with events after TOMORROW" do
      response = Tour.after(Date.tomorrow).pluck(:title)
      correct  = [tour_in_week_awards.title ]
      expect(response).to eq( correct )
    end
    it "properly selects and orders tours with events before TOMORROW" do
      response = Tour.before(Date.tomorrow).pluck(:title)
      correct  = [tour_today_tomorrow.title, tour_today.title]
      expect(response).to eq( correct )
    end
  end

end
