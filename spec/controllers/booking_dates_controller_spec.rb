require 'rails_helper'

RSpec.describe BookingDatesController, type: :controller do

  # This should return the minimal set of attributes required to create a valid
  # BookingDate. As you add validations to BookingDate, be sure to
  # adjust the attributes here as well.
  let(:valid_attributes) {
    skip("Add a hash of attributes valid for your model")
  }

  let(:invalid_attributes) {
    skip("Add a hash of attributes invalid for your model")
  }

  # This should return the minimal set of values that should be in the session
  # in order to pass any filters (e.g. authentication) defined in
  # BookingDatesController. Be sure to keep this updated too.
  let(:valid_session) { {} }

  describe "PUT #commit" do
    context "with valid params" do
      let(:new_attributes) {
        skip("Add a hash of attributes valid for your model")
      }

      it "updates the requested booking_date" do
        booking_date = BookingDate.create! valid_attributes
        put :commit, params: {id: booking_date.to_param, booking_date: new_attributes}, session: valid_session
        booking_date.reload
        skip("Add assertions for updated state")
      end

      it "redirects to the booking_date" do
        booking_date = BookingDate.create! valid_attributes
        put :commit, params: {id: booking_date.to_param, booking_date: valid_attributes}, session: valid_session
        expect(response).to redirect_to(booking_date)
      end
    end

    context "with invalid params" do
      # test with bad: date_id, tour_id, company_email
      it "returns a success response (i.e. to display the 'edit' template)" do
        booking_date = BookingDate.create! valid_attributes
        put :commit, params: {id: booking_date.to_param, booking_date: invalid_attributes}, session: valid_session
        expect(response).to be_success
      end
    end
  end

end
