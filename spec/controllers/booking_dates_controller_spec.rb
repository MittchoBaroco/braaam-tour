require 'rails_helper'

RSpec.describe BookingDatesController, type: :controller do

  let!(:booking_date) {
    FactoryBot.create(:booking_date)
  }
  let!(:company) {
    FactoryBot.create(:company, email: 'test@example.com')
  }
  let!(:booked_date) {
    FactoryBot.create(:booked_date)
  }

  let(:valid_attributes) {
    {id: booking_date.id, company_id: company.id}
  }
  let(:valid_email) {
    {id: booking_date.id, company_email: company.email}
  }

  let(:invalid_attributes) {
    {id: "john", company_id: "jane"}
  }
  let(:invalid_booking_id) {
    {id: 0, company_id: company.id}
  }
  let(:invalid_company_id) {
    {id: booking_date.id, company_id: 0}
  }
  let(:invalid_company_email) {
    {id: booking_date.id, company_email: "invalid@example.com"}
  }

  # This should return the minimal set of values that should be in the session
  # in order to pass any filters (e.g. authentication) defined in
  # BookingDatesController. Be sure to keep this updated too.
  let(:valid_session) { {} }

  describe "PUT #commit" do
    context "with valid params" do
      it "updates the requested booking_date with company_id" do
        put :commit, params: {id: booking_date.to_param,
                      booking_date: valid_attributes}, session: valid_session
        booking_date.reload
        expect(booking_date.company_id).to eq(company.id)
      end
      it "updates the requested booking_date with company_email" do
        put :commit, params: {id: booking_date.to_param,
                      booking_date: valid_email}, session: valid_session
        booking_date.reload
        expect(booking_date.company_id).to eq(company.id)
      end
      it "redirects back to the tour" do
        # booking_date = BookingDate.create! valid_attributes
        put :commit, params: {id: booking_date.to_param,
                      booking_date: valid_attributes}, session: valid_session
        expect(response).to redirect_to(booking_date.tour)
      end
    end

    xcontext "with invalid params" do
      # test with bad: date_id, company_email
      it "returns error on tour page - with invalid_attributes" do
        #booking_date = BookingDate.create! valid_attributes
        put :commit, params: {id: booking_date.to_param,
                      booking_date: invalid_attributes}, session: valid_session
        expect(response).to be_successful
      end
      it "returns error on tour page - with bad booking_id" do
        #booking_date = BookingDate.create! valid_attributes
        put :commit, params: {id: booking_date.to_param,
                      booking_date: invalid_booking_id}, session: valid_session
        expect(response).to be_successful
      end
      it "returns error on tour page - with bad company_id" do
        #booking_date = BookingDate.create! valid_attributes
        put :commit, params: {id: booking_date.to_param,
                      booking_date: invalid_company_id}, session: valid_session
        expect(response).to be_successful
      end
      it "returns error on tour page - with bad company_email" do
        #booking_date = BookingDate.create! valid_attributes
        put :commit, params: {id: booking_date.to_param,
                      booking_date: invalid_company_email}, session: valid_session
        expect(response).to be_successful
      end
    end
  end

end
