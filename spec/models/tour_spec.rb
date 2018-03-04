require 'rails_helper'

RSpec.describe Tour, type: :model do

  let!(:tour)             { FactoryBot.create(:tour) }
  let!(:tour_with_awards) { FactoryBot.create(:tour, :with_awards) }

  context "verify factories" do
    it 'has a valid Factory' do
      expect(tour).to be_valid
    end

    it 'has a valid Factory with awards' do
      expect(tour_with_awards).to be_valid
    end
  end

  context "Check company validations" do

    it { should validate_presence_of(:title) }
    it { should validate_presence_of(:description) }
    it { should validate_presence_of(:video_uri) }

    it { should validate_length_of(:title).is_at_least(2) }
    it { should validate_length_of(:description).is_at_least(2) }
    it { should validate_length_of(:video_uri).is_at_least(2) }

    it { should allow_value(%w(true false)).for(:tech_help) }
    it { should allow_value(%w(true false)).for(:housing) }
    it { should allow_value(%w(true false)).for(:catering) }
    it { should allow_value(%w(true false)).for(:transport) }

    # money is not working with shoulda

    it "invalidated normal_price with 0" do
      invalid_tour = tour.dup
      invalid_tour.price_normal = -1
      expect(invalid_tour).to_not be_valid
    end

    it "invalidated braaam_price with 0" do
      invalid_tour = tour.dup
      invalid_tour.price_braaam = -1
      expect(invalid_tour).to_not be_valid
    end

  end

  context "Check company Relationships" do
    it { should have_many(:awards) }
    it { should have_many(:booking_dates) }
    it { should have_many(:companies).through(:booking_dates) }
  end

end
