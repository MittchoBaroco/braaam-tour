require 'rails_helper'

RSpec.describe Tour, type: :model do

  let!(:tour_in_week)        { FactoryBot.create(:tour, title: "In Week") }
  let!(:tour_today_tomorrow) { FactoryBot.create(:tour, title: "Today & Tomorrow") }
  let!(:tour_tomorrow)       { FactoryBot.create(:tour_w_image, title: "Tomorrow") }
  let!(:tour_today)          { FactoryBot.create(:tour_w_image, title: "Today") }

  let!(:date_in_week)       { FactoryBot.create(:booking_date,
                              day: (Date.today + 7.day),
                              tour_id: tour_in_week.id) }
  let!(:date_tt_tomorrow)   { FactoryBot.create(:booking_date,
                              day: (Date.tomorrow),
                              tour_id: tour_today_tomorrow.id) }
  let!(:date_tt_today)      { FactoryBot.create(:booking_date,
                              day: (Date.today),
                              tour_id: tour_today_tomorrow.id) }
  let!(:date_tomorrow)      { FactoryBot.create(:booking_date,
                              day: (Date.tomorrow), tour_id: tour_tomorrow.id) }
  let!(:date_today)         { FactoryBot.create(:booking_date,
                              day: (Date.today), tour_id: tour_today.id) }

  let!(:highlight_tours)    {
    [
      FactoryBot.create(:tour, :highlighted, title: "highlighted 1"),
      FactoryBot.create(:tour, :highlighted, title: "highlighted 2"),
      FactoryBot.create(:tour, :highlighted, title: "highlighted 3"),
      FactoryBot.create(:tour, :highlighted, title: "highlighted 4")
    ]
  }

  context "verify factories" do
    it 'has a valid Factory' do
      expect(tour_today).to be_valid
    end
  end

  context "Check company validations" do
    it { should validate_presence_of(:title) }
    it { should validate_presence_of(:description) }
    it { should validate_presence_of(:tour_caption) }
    it { should validate_presence_of(:tour_artist_name) }
    it { should validate_presence_of(:tour_artist_email) }
    it { should validate_presence_of(:tour_staff_number) }

    describe "presence of tour_start_date" do
      context "without booking days associate" do
        it "allow blank" do
          expect(FactoryBot.create(:tour)).to be_valid
        end
      end

      context "with booking days associate" do
        it "validates presence of tour_start_date" do
          t = FactoryBot.create(:tour)
          t.booking_dates.create(FactoryBot.attributes_for(:booking_date, day: (Date.today + 1.day)))
          expect(t).to be_valid

          t.tour_start_date = ""
          expect(t).to_not be_valid
          expect( t.errors.messages).to include(
                      {:tour_start_date=>["can't be blank"]} )
        end

        it "validates presence of tour_end_date" do
          t = FactoryBot.create(:tour)
          t.booking_dates.create(FactoryBot.attributes_for(:booking_date, day: (Date.today + 1.day)))
          expect(t).to be_valid

          t.tour_end_date = ""
          expect(t).to_not be_valid
          expect( t.errors.messages).to include(
                      {:tour_end_date=>["can't be blank"]} )
        end
      end
    end

    it { should validate_length_of(:title).is_at_least(2) }
    it { should validate_length_of(:description).is_at_least(2) }
    it { should validate_length_of(:tour_caption).is_at_least(2) }
    it { should validate_length_of(:tour_artist_name).is_at_least(2) }
    it { should validate_length_of(:tour_artist_email).is_at_least(6) }

    it { should validate_numericality_of(:tour_staff_number).only_integer.is_greater_than_or_equal_to(0) }

    it { should allow_value(%w(true false)).for(:housing) }
    it { should allow_value(%w(true false)).for(:catering) }

    it { should allow_values('',  nil, 'http://foo.com', 'http://foo.com/',
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
    it { should have_many(:comments) }
    it { should have_many(:booking_dates).order(day: :asc)
                                         .inverse_of(:tour)
                                         .dependent(:destroy) }
    it { should have_many(:companies).through(:booking_dates) }
    it { belong_to(:creator).class_name("Company").with_foreign_key(:company_id).optional }
  end

  context "test nested attributes" do
    it { should accept_nested_attributes_for(:awards) }
    it { should accept_nested_attributes_for(:booking_dates) }
  end

  context "test scopes" do
    it "properly selects and orders future tours" do
      # response = Tour.future.pluck(:title)
      response = Tour.future.map{|t| t.title}
      # pp response
      correct  = [tour_today_tomorrow.title, tour_tomorrow.title, tour_in_week.title ]
      expect(response).to eq( correct )
    end
    it "properly selects and orders current (today or future) tours" do
      response = Tour.current.map{|t| t.title}
      correct  = [tour_today.title, tour_today_tomorrow.title, tour_tomorrow.title, tour_in_week.title ]
      expect(response).to eq( correct )
      # expect(response).to match_array( correct )
    end
    it "properly selects and orders tours with events after TOMORROW" do
      response = Tour.after(Date.tomorrow).map{|t| t.title}
      correct  = [tour_in_week.title ]
      expect(response).to eq( correct )
    end
    it "properly selects and orders tours with events before TOMORROW" do
      # response = Tour.before(Date.tomorrow).map{&:title}
      response = Tour.before(Date.tomorrow).map{|t| t.title}
      correct  = [tour_today.title, tour_today_tomorrow.title]
      expect(response).to eq( correct )
    end
    it "properly selects index carousel tour - all in future with amage" do
      # TODO: add image to tour and be sure its scopped
      response = Tour.index_collection.map{|t| t.title}
      correct  = [tour_today.title, tour_tomorrow.title]
      expect(response).to eq( correct )
    end
    it "properly selects only carousel tour - excluding (id)" do
      # TODO: add image to tour and be sure its scopped
      response = Tour.show_collection(tour_tomorrow.id).map{|t| t.title}
      correct  = [tour_today.title]
      expect(response).to eq( correct )
    end
  end

  context "highlighted" do
    it "shows the correct highlighted tours" do
      active_record_titles = Tour.highlighted.pluck(:title)

      expect(active_record_titles).to eq(["highlighted 4", "highlighted 3", "highlighted 2"])
    end

    it "shows the correct highlighted tours if a old one is refresh" do
      Tour.find_by(title: "highlighted 1").update(highlighted_at: DateTime.now)
      active_record_titles = Tour.highlighted.pluck(:title)

      expect(active_record_titles).to eq(["highlighted 1", "highlighted 4", "highlighted 3"])
    end

    it "shows the correct highlighted tours if a new one is mark" do
      active_record_titles = Tour.highlighted.pluck(:title)

      expect(active_record_titles).to eq(["highlighted 4", "highlighted 3", "highlighted 2"])
    end
  end

  context "status" do
    it "return future if start date is future from today" do
      tour = FactoryBot.create(:tour)
      tour.booking_dates.create(FactoryBot.attributes_for(:booking_date, day: (Date.today + 1.day)))
      tour.reload
      expect(tour.status).to eq("Future")
    end

    it "return on going if start date is today or past and end date is today or future" do
      tour = FactoryBot.create(:tour)
      tour.booking_dates.create(FactoryBot.attributes_for(:booking_date, day: (Date.today)))
      tour.reload
      expect(tour.status).to eq("On going")
    end

    # it "return archived if end date is past" do
    #   expect(tour_yesterday.status).to eq("Archived")
    # end

    it "return highlighted if highlighted_at is present" do
      expect(highlight_tours.last.status).to eq("Highlighted")
    end

    it "return past highlight if highlighted_at is present and ID is not in scope" do
      expect(highlight_tours.first.status).to eq("Past Highlight")
    end

    it "return true if tour is highlighted?" do
      expect(highlight_tours.last.highlighted?).to eq(true)
    end
  end

  context "methods" do
    describe "set_start_date" do
      it "assign start_date at creation" do
        tour = FactoryBot.create(:tour)
        tour.booking_dates.create(FactoryBot.attributes_for(:booking_date, day: (Date.today)))
        tour.reload
        expect(tour.tour_start_date).to eq(Date.today)
      end

      it "assign correct start_date on update" do
        tour = FactoryBot.create(:tour)
        tour.booking_dates.create(FactoryBot.attributes_for(:booking_date, day: (Date.today + 1.day)))
        tour.reload
        expect(tour.tour_start_date).to eq(Date.today + 1.day)

        tour.booking_dates.create(FactoryBot.attributes_for(:booking_date, day: (Date.today)))
        expect(tour.tour_start_date).to eq(Date.today)
      end
    end

    describe "set_end_date" do
      it "assign end_date at creation" do
        tour = FactoryBot.create(:tour)
        tour.booking_dates.create(FactoryBot.attributes_for(:booking_date, day: (Date.today)))
        tour.reload
        expect(tour.tour_end_date).to eq(Date.today)
      end

      it "assign correct end_date on update" do
        tour = FactoryBot.create(:tour)
        tour.booking_dates.create(FactoryBot.attributes_for(:booking_date, day: (Date.today + 1.day)))
        tour.reload
        expect(tour.tour_end_date).to eq(Date.today + 1.day)

        tour.booking_dates.create(FactoryBot.attributes_for(:booking_date, day: (Date.today + 2.day)))
        expect(tour.tour_end_date).to eq(Date.today + 2.day)
      end
    end

    describe "#creator_name" do
      it "return Braaam if creator is missing" do
        t = tour_today.dup
        expect(t.creator_name).to eq("Braaam")
      end

      it "return the name of the creator" do
        t = tour_today.dup
        c = FactoryBot.build(:company, name: 'pony')
        t.creator = c
        expect(t.creator_name).to eq('pony')
      end
    end
  end

end
