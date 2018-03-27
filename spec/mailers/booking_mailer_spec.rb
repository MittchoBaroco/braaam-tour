require "rails_helper"

RSpec.describe BookingMailer, type: :mailer do
  let(:company) { FactoryBot.build(:company) }
  let(:tour_name) { "Mr Banana" }
  let(:date) { Date.today }
  let(:confirmation_subject) { "Booking Confirmation for #{tour_name}" }
  let(:notification_subject) { "Booking Notification for #{tour_name}" }

  describe "booking_confirmation" do
    let(:mail) { BookingMailer.booking_confirmation(company, date, tour_name) }

    it "renders the headers" do
      expect(mail.subject).to eq(confirmation_subject)
      expect(mail.to).to eq([company.email])
      expect(mail.from).to eq(["no-reply@braaam.com"])
    end

    it "renders the body" do
      expect(mail.body.encoded).to match("Braaamjour")
    end
  end

  describe "admins_notification" do
    let(:mail) { BookingMailer.admins_notification(company, date, tour_name) }

    it "renders the headers" do
      expect(mail.subject).to eq(notification_subject)
      expect(mail.to).to eq(["jd.zaccariotto@gmail.com"])
      expect(mail.from).to eq(["no-reply@braaam.com"])
    end

    it "renders the body" do
      expect(mail.body.encoded).to match("Braaam")
    end
  end

end
