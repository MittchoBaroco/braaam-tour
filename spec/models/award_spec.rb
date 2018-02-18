require 'rails_helper'

RSpec.describe Award, type: :model do

  let!(:award) { FactoryBot.create(:award) }

  context "verify factory" do
    it 'has a valid Factory' do
      expect(award).to be_valid
    end
  end

  context "Check award validations" do

    it { should validate_presence_of(:caption) }
    it { should validate_presence_of(:institution) }
    it { should validate_presence_of(:award_year) }

    it { should validate_length_of(:caption).is_at_least(2) }
    it { should validate_length_of(:institution).is_at_least(2) }

    it do
      should allow_values("2000", "2018").
        for(:award_year).
        with_message('year must be numeric and greater than or equal to 2000')
    end

    it do
      should_not allow_values("1998", "18", "a", "xxxx").
        for(:award_year).
        with_message('year must be numeric and greater than or equal to 2000')
    end

    it do
      should validate_uniqueness_of(:caption).
        scoped_to(:institution, :award_year).
        with_message('award must be unique in fields: caption, award_year and institution')
    end
  end

  context "Check award Relationships" do
    it { should belong_to(:tour) }
  end
end
