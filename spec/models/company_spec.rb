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
      it { should validate_presence_of(:company_address_line1) }
      it { should validate_presence_of(:company_country) }
      it { should validate_presence_of(:company_npa) }
      it { should validate_presence_of(:company_city) }
      it { should validate_presence_of(:reference_person_full_name) }

      it { should validate_length_of(:company_address_line1).is_at_least(6) }
      it { should validate_length_of(:company_country).is_at_least(2) }
      it { should validate_length_of(:company_npa).is_at_least(1) }
      it { should validate_length_of(:company_city).is_at_least(2) }
      it { should validate_length_of(:reference_person_full_name).is_at_least(2) }
      it { should validate_length_of(:vat_number).is_at_least(2).allow_nil }
      it { should validate_length_of(:ape).is_at_least(2).allow_nil }
      it { should validate_length_of(:siret).is_at_least(2).allow_nil }

    end

    context "Check company Relationships" do
      it { should have_many(:booking_dates) }
      it { should have_many(:tours).through(:booking_dates) }
      it { should have_many(:created_tours).with_foreign_key("company_id").class_name("Tour")}
    end

end
