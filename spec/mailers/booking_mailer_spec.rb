require "rails_helper"

RSpec.describe BookingMailer, type: :mailer do
  describe "creation_confirmation" do
    let(:mail) { BookingMailer.creation_confirmation }

    it "renders the headers" do
      expect(mail.subject).to eq("Creation confirmation")
      expect(mail.to).to eq(["to@example.org"])
      expect(mail.from).to eq(["from@example.com"])
    end

    it "renders the body" do
      expect(mail.body.encoded).to match("Hi")
    end
  end

  describe "admins_notification" do
    let(:mail) { BookingMailer.admins_notification }

    it "renders the headers" do
      expect(mail.subject).to eq("Admins notification")
      expect(mail.to).to eq(["to@example.org"])
      expect(mail.from).to eq(["from@example.com"])
    end

    it "renders the body" do
      expect(mail.body.encoded).to match("Hi")
    end
  end

end
