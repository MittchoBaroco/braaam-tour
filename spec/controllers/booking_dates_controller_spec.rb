require 'rails_helper'

RSpec.describe BookingDatesController, type: :controller do
  before(:each) do
    sign_in company
  end

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
    {id: booking_date.id, company_id: "jane"}
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
  let(:valid_session) {}

  describe "PUT #signup" do
    include ActiveJob::TestHelper

    after do
      clear_enqueued_jobs
    end

    context "with valid params" do
      it "updates the requested booking_date with company_id" do
        put :signup, params: {id: booking_date.to_param,
                      booking_date: valid_attributes}, session: valid_session
        booking_date.reload
        expect(booking_date.company_id).to eq(company.id)
        expect(enqueued_jobs.size).to eq(2)
      end
      it "updates the requested booking_date with company_email" do
        put :signup, params: {id: booking_date.to_param,
                      booking_date: valid_email}, session: valid_session
        booking_date.reload
        expect(booking_date.company_id).to eq(company.id)
      end
      it "redirects back to the tour" do
        # booking_date = BookingDate.create! valid_attributes
        put :signup, params: {id: booking_date.to_param,
                        booking_date: valid_attributes}, session: valid_session
        expect(response).to redirect_to(booking_date.tour)
      end
    end

    context "try to book an already booked date" do
      it "returns user to tour page" do
        put :signup, params: {id: booked_date.to_param,
                        booking_date: valid_attributes}, session: valid_session
        expect(response).to redirect_to(booked_date.tour)
      end
      it "keep the original company booked" do
        company = booked_date.company
        put :signup, params: {id: booked_date.to_param,
                              booking_date: valid_attributes},
                              session: valid_session
        booked_date.reload
        expect(booked_date.company).not_to be(valid_attributes[:company])
      end
      it "give user a double booking alert" do
        company = booked_date.company
        put :signup, params: {id: booked_date.to_param,
                              booking_date: valid_attributes},
                              session: valid_session
        booked_date.reload
        expect(response).to redirect_to(booked_date.tour)
        expect(flash[:alert]).to be_present
      end
    end

    context "with invalid params" do
      # test with bad: date_id, company_email
      it "returns error on tour page - with invalid_attributes" do
        #booking_date = BookingDate.create! valid_attributes
        put :signup, params: {id: booking_date.to_param,
                              booking_date: invalid_attributes},
                              session: valid_session
        # expect(response).to be_successful
        expect(response).to be_successful
        expect(controller).to set_flash.now[:alert]
      end
      it "returns error on tour page - with bad company_id" do
        #booking_date = BookingDate.create! valid_attributes
        put :signup, params: {id: booking_date.to_param,
                              booking_date: invalid_company_id},
                              session: valid_session
        # expect(response).to be_successful
        expect(response).to be_successful
        expect(controller).to set_flash.now[:alert]
      end
      it "returns error on tour page - with bad company_email" do
        #booking_date = BookingDate.create! valid_attributes
        put :signup, params: {id: booking_date.to_param,
                              booking_date: invalid_company_email},
                              session: valid_session
        # expect(response).to be_successful
        expect(response).to be_successful
        expect(controller).to set_flash.now[:alert]
      end
    end
  end

end
