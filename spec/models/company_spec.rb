require 'rails_helper'

RSpec.describe Company, type: :model do

    let!(:company)      { FactoryBot.create(:company) }

    context "verify factory" do

      it 'has a valid Factory' do
        expect(company).to be_valid
      end

    end

    context "Check company validations" do

      it { should validate_uniqueness_of(:email).case_insensitive }

      it { should validate_presence_of(:email) }
      it { should validate_presence_of(:name) }

      it { should validate_length_of(:email).is_at_least(6) }
      it { should validate_length_of(:name).is_at_least(2) }

    end

    context "Check company Relationships" do
      it { should have_many(:booking_dates) }
      it { should have_many(:tours).through(:booking_dates) }
    end

end
