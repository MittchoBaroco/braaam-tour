require "rails_helper"

RSpec.describe BookingMailer, type: :mailer do
  let(:company) { FactoryBot.build(:company) }
  let(:tour_name) { "Mr Banana" }
  let(:date) { Date.today }

  describe "booking_confirmation" do
    let(:mail) { BookingMailer.booking_confirmation(company, date, tour_name) }

    it "renders the headers" do
      expect(mail.subject).to eq("Confirmation de reservation pour #{tour_name}")
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
      expect(mail.subject).to eq("Notification de reservation pour #{tour_name}")
      expect(mail.to).to eq(["jd.zaccariotto@gmail.com"])
      expect(mail.from).to eq(["no-reply@braaam.com"])
    end

    it "renders the body" do
      expect(mail.body.encoded).to match("Braaam")
    end
  end

end
