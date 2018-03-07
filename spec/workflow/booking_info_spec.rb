require 'rails_helper'

RSpec.describe "BookingInfo" do

  let!(:tour)                  { FactoryBot.create(:tour) }
  let!(:company)               { FactoryBot.create(:company) }
  let(:booking_date)           { FactoryBot.create(:booking_date, tour: tour) }

  context "Booking controller sends signup info to BookingInfo" do
    before(:each) do
      @input = {params: @params, action: :signup}
    end
    describe "params include: company_email" do
      before(:each) do
        @params = {id: booking_date.id, company_email: company.email}
      end
      it "signup returns -- correct company" do
        answer, _ = BookingStrategy.new(params: @params, action: :signup).run
        expect(answer).to eq(company)
      end
      it "signup returns -- correct company_id" do
        _, answer = BookingStrategy.new(params: @params, action: :signup).run
        expect(answer).to eq( {company_id: company.id} )
      end
    end
    describe "params include: company_id" do
      before(:each) do
        @params = {id: booking_date.id, company_id: company.id}
      end
      it "signup returns -- correct company" do
        answer, _ = BookingStrategy.new(params: @params, action: :signup).run
        expect(answer).to eq(company)
      end
      it "signup returns -- correct company_id" do
        _, answer = BookingStrategy.new(params: @params, action: :signup).run
        expect(answer).to eq( {company_id: company.id} )
      end
    end
  end
end
