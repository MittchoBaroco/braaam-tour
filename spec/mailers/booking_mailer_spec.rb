require "rails_helper"

RSpec.describe BookingMailer, type: :mailer do
  let(:company) { FactoryBot.build(:company) }
  let(:tour_name) { "Mr Banana" }
  let(:date) { Date.today }

  describe "creation_confirmation" do
    let(:mail) { BookingMailer.creation_confirmation(company, date, tour_name) }

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
    let(:mail) { BookingMailer.admins_notification }

    it "renders the headers" do
      expect(mail.subject).to eq("Admins notification")
      expect(mail.to).to eq(["to@example.org"])
      expect(mail.from).to eq(["no-reply@braaam.com"])
    end

    it "renders the body" do
      expect(mail.body.encoded).to match("Hi")
    end
  end

end
