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

    # The validate_length_of matcher doesn't support integer columns, only string columns.
    # it { should validate_length_of(:award_year).is_at_least(4) }

    it "validate length of award_year" do
      invalid_award = award.dup
      invalid_award.award_year = 3
      expect(invalid_award).to_not be_valid
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
