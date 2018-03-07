require 'rails_helper'

RSpec.describe Manager, type: :model do

  let!(:manager)      { FactoryBot.create(:manager) }

  context "verify factory" do

    it 'has a valid Factory' do
      expect(manager).to be_valid
    end

  end

  context "Check manager validations" do

    it { should validate_presence_of(:email) }
    it { should validate_presence_of(:full_name) }
    it { should validate_presence_of(:password) }

    it { should validate_length_of(:email).is_at_least(6) }
    it { should validate_length_of(:full_name).is_at_least(2) }

    it { should validate_uniqueness_of(:email).case_insensitive }
    it { should validate_uniqueness_of(:full_name).case_insensitive }
    # it { should validate_uniqueness_of(:email).ignoring_case_sensitivity }

  end

end
